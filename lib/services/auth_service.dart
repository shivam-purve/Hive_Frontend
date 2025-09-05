// lib/features/auth/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  AuthService(this._api);
  final ApiClient _api;

  /// Persist token & token type for future calls.
  Future<void> _saveToken(String accessToken, {String tokenType = 'Bearer'}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('token_type', tokenType);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('token_type');
  }

  Future<bool> get isLoggedIn async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString('access_token') ?? '').isNotEmpty;
  }

  /// ---------------------------
  /// SIGN UP
  /// ---------------------------
  /// Body must include name, email, age, gender, password (displayName/bio/avatar optional)
  /// per your docs. :contentReference[oaicite:1]{index=1}
  Future<dynamic> signUp({
    required String name,
    required String email,
    required int age,
    required String gender,
    required String password,
    String? displayName,
    String? bio,
    String? avatar,
  }) async {
    final body = <String, dynamic>{
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'password': password,
      if (displayName?.isNotEmpty == true) 'displayName': displayName,
      if (bio?.isNotEmpty == true) 'bio': bio,
      if (avatar?.isNotEmpty == true) 'avatar': avatar,
    };

    // Docs show a minor inconsistency (/users/signup vs /user/signup).
    // We'll hit the canonical full endpoint first (/user/signup) and fall back once if needed.
    try {
      final res = await _api.post('/user/signup', body: body);
      return res;
    } on ApiException catch (e) {
      if (e.statusCode == 404) {
        // Fallback to the plural path noted in the PDF
        return _api.post('/users/signup', body: body);
      }
      rethrow;
    }
  }

  /// ---------------------------
  /// LOGIN
  /// ---------------------------
  /// Returns { access_token, token_type } per docs. :contentReference[oaicite:2]{index=2}
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final res = await _api.post('/user/login', body: {
      'email': email,
      'password': password,
    });

    final token = (res?['access_token'] ?? '').toString();
    final type = (res?['token_type'] ?? 'bearer').toString();
    if (token.isEmpty) {
      throw ApiException('Login failed: token missing');
    }
    // Normalize token type capitalization
    await _saveToken(token, tokenType: type[0].toUpperCase() + type.substring(1));
  }

  /// ---------------------------
  /// ME (current user)
  /// ---------------------------
  /// GET /user/users/me with Authorization header. :contentReference[oaicite:3]{index=3}
  Future<Map<String, dynamic>> getCurrentUser() async {
    final res = await _withAutoRefresh<Map<String, dynamic>>(
          () async => await _api.get('/user/users/me', auth: true) as Map<String, dynamic>,
    );
    return res;
  }

  /// ---------------------------
  /// REFRESH TOKEN
  /// ---------------------------
  /// POST /user/refresh; returns a new access_token. :contentReference[oaicite:4]{index=4}
  Future<void> refreshToken() async {
    final res = await _api.post('/user/refresh', auth: true);
    final token = (res?['access_token'] ?? '').toString();
    final type = (res?['token_type'] ?? 'bearer').toString();
    if (token.isEmpty) {
      throw ApiException('Refresh failed: token missing');
    }
    await _saveToken(token, tokenType: type[0].toUpperCase() + type.substring(1));
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  /// POST /user/logout; clear local token. :contentReference[oaicite:5]{index=5}
  Future<void> logout() async {
    try {
      await _api.post('/user/logout', auth: true);
    } catch (_) {
      // even if server call fails, clear local session
    }
    await _clearToken();
  }

  /// Helper that retries once on 401 by refreshing token.
  Future<T> _withAutoRefresh<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        try {
          await refreshToken();
          return await run();
        } catch (_) {
          // bubble up original 401 if refresh also fails
          rethrow;
        }
      }
      rethrow;
    }
  }
}
