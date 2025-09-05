// lib/services/search_service.dart
import 'api_client.dart';

class SearchService {
  final ApiClient _api = ApiClient();

  Future<List<Map<String, dynamic>>> searchPosts({
    String query = '',
    String status = 'All', // All | Safe | Under Review | Flagged
  }) async {
    // Build query string manually
    final params = <String, String>{};
    if (query.isNotEmpty) params['q'] = query;
    if (status != 'All') params['status'] = status.toLowerCase();

    final qs = params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');
    final path = qs.isNotEmpty ? '/post/?$qs' : '/post/';

    try {
      final res = await _api.get(path, auth: false);

      if (res is List) {
        return res.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
    } catch (_) {
      // ignore and fallback
    }

    // fallback client-side filter
    final all = await _api.get('/post/', auth: false) as List<dynamic>;
    final lowerQuery = query.toLowerCase();
    final filtered = all.where((p) {
      if (p is! Map) return false;
      final username = (p['author'] is Map ? (p['author']['name'] ?? '') : (p['username'] ?? '')).toString().toLowerCase();
      final content = (p['content'] ?? '').toString().toLowerCase();
      final matchesQuery = lowerQuery.isEmpty || username.contains(lowerQuery) || content.contains(lowerQuery);

      if (status == 'All') return matchesQuery;
      final moderation = (p['moderation_status'] ?? p['status'] ?? '').toString();
      if (status == 'Safe') return matchesQuery && moderation.toLowerCase().contains('safe');
      if (status == 'Under Review') return matchesQuery && moderation.toLowerCase().contains('review');
      if (status == 'Flagged') return matchesQuery && moderation.toLowerCase().contains('flag');
      return matchesQuery;
    }).map((e) => Map<String, dynamic>.from(e as Map)).toList();

    return filtered;
  }
}
