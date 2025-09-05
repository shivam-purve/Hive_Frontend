// lib/core/api/api_client.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Change this for different environments:
/// NOTE: If your API runs on your development machine and you test on Android Emulator,
/// use "http://10.0.2.2:8000" instead of localhost.
const String kBaseUrl = 'https://hive-backend-tnmw.onrender.com';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({String? baseUrl, http.Client? client})
      : baseUrl = (baseUrl ?? kBaseUrl).replaceAll(RegExp(r'/$'), ''),
        _client = client ?? http.Client();

  static const Duration _timeout = Duration(seconds: 25);

  Future<dynamic> get(
      String path, {
        bool auth = false,
        Map<String, String>? headers,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await _client
        .get(uri, headers: await _headers(auth: auth, extra: headers))
        .timeout(_timeout);
    return _handleResponse(res);
  }

  Future<dynamic> post(
      String path, {
        bool auth = false,
        Map<String, dynamic>? body,
        Map<String, String>? headers,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await _client
        .post(
      uri,
      headers: await _headers(auth: auth, extra: headers),
      body: body == null ? null : jsonEncode(body),
    )
        .timeout(_timeout);
    return _handleResponse(res);
  }

  Future<dynamic> put(
      String path, {
        bool auth = false,
        Map<String, dynamic>? body,
        Map<String, String>? headers,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await _client
        .put(
      uri,
      headers: await _headers(auth: auth, extra: headers),
      body: body == null ? null : jsonEncode(body),
    )
        .timeout(_timeout);
    return _handleResponse(res);
  }

  Future<dynamic> delete(
      String path, {
        bool auth = false,
        Map<String, String>? headers,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await _client
        .delete(uri, headers: await _headers(auth: auth, extra: headers))
        .timeout(_timeout);
    return _handleResponse(res);
  }

  /// Simple multipart uploader (useful later for /storage routes in your doc).
  Future<dynamic> postMultipart(
      String path, {
        required Map<String, String> fields,
        required File file,
        String fileField = 'file',
        bool auth = true,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final req = http.MultipartRequest('POST', uri);

    // Headers (without JSON content-type)
    final hdrs = await _headers(auth: auth, json: false);
    req.headers.addAll(hdrs);

    // Fields
    req.fields.addAll(fields);

    // File
    final length = await file.length();
    final stream = http.ByteStream(file.openRead());
    final multipart = http.MultipartFile(
      fileField,
      stream,
      length,
      filename: file.path.split('/').last,
    );
    req.files.add(multipart);

    final res = await http.Response.fromStream(await req.send()).timeout(_timeout);
    return _handleResponse(res);
  }

  Future<Map<String, String>> _headers({
    required bool auth,
    Map<String, String>? extra,
    bool json = true,
  }) async {
    final headers = <String, String>{
      if (json) 'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (auth) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final tokenType = prefs.getString('token_type') ?? 'Bearer';
      if (token == null || token.isEmpty) {
        throw ApiException('Not authenticated', statusCode: 401);
      }
      headers['Authorization'] = '$tokenType $token';
    }

    if (extra != null) headers.addAll(extra);
    return headers;
  }

  dynamic _handleResponse(http.Response res) {
    final status = res.statusCode;
    dynamic decoded;
    if (res.body.isNotEmpty) {
      try {
        decoded = jsonDecode(res.body);
      } catch (_) {
        decoded = res.body;
      }
    }

    if (status >= 200 && status < 300) {
      return decoded;
    }
    final message = decoded is Map && decoded['detail'] != null
        ? decoded['detail'].toString()
        : 'HTTP $status';
    throw ApiException(message, statusCode: status, data: decoded);
  }

  void dispose() => _client.close();
}
