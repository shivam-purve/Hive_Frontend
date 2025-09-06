// lib/services/user_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/services/api_client.dart';

class UserService {
  final _api = ApiClient();

  /// Fetch current logged-in user's profile
  Future<Map<String, dynamic>> getCurrentUser() async {
    final res = await _api.get('$kBaseUrl/user/me', auth: true);
    return res as Map<String, dynamic>;
  }

  /// Fetch posts by user ID
  Future<List<dynamic>> getUserPosts(String userId) async {
    final res = await _api.get(
      '$kBaseUrl/post/users/$userId/posts',
      auth: true,
    );
    return res as List<dynamic>;
  }

  // /// Like a post
  // Future<void> likePost(String postId) async {
  //   await _api.post('$kBaseUrl/posts/$postId/like', auth: true);
  // }

  // /// Dislike a post
  // Future<void> dislikePost(String postId) async {
  //   await _api.post('$kBaseUrl/posts/$postId/dislike', auth: true);
  // }
}
