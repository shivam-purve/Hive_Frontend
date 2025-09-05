// lib/services/user_service.dart
import 'api_client.dart';

class UserService {
  final _api = ApiClient();

  /// Fetch current logged-in user's profile
  Future<Map<String, dynamic>> getCurrentUser() async {
    final res = await _api.get('/user/users/me', auth: true);
    return res as Map<String, dynamic>;
  }

  /// Fetch posts by user ID
  Future<List<dynamic>> getUserPosts(String userId) async {
    final res = await _api.get('/user/$userId/posts', auth: true);
    return res as List<dynamic>;
  }

  /// Like a post
  Future<void> likePost(String postId) async {
    await _api.post('/posts/$postId/like', auth: true);
  }

  /// Dislike a post
  Future<void> dislikePost(String postId) async {
    await _api.post('/posts/$postId/dislike', auth: true);
  }
}
