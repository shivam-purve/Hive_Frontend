// lib/services/post_service.dart
import 'api_client.dart';

class PostService {
  final _api = ApiClient();

  /// ---------------------------
  /// Fetch all posts
  /// ---------------------------
  Future<List<dynamic>> fetchPosts() async {
    final res = await _api.get('/posts', auth: true);
    return res as List<dynamic>;
  }

  /// ---------------------------
  /// Like a post
  /// ---------------------------
  Future<void> likePost(String postId) async {
    await _api.post('/posts/$postId/like', auth: true);
  }

  /// ---------------------------
  /// Dislike a post
  /// ---------------------------
  Future<void> dislikePost(String postId) async {
    await _api.post('/posts/$postId/dislike', auth: true);
  }

  /// ---------------------------
  /// Add a comment to a post
  /// ---------------------------
  Future<void> addComment(String postId, String content) async {
    await _api.post(
      '/posts/$postId/comments',
      body: {"content": content},
      auth: true,
    );
  }

  /// ---------------------------
  /// Create a new post (used in create.dart)
  /// ---------------------------
  Future<Map<String, dynamic>> createPost(String content) async {
    final res = await _api.post(
      '/posts',
      body: {"content": content},
      auth: true,
    );
    return res as Map<String, dynamic>;
  }
}
