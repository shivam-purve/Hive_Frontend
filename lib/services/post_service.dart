// // lib/services/post_service.dart
// import 'apisupabase.dart';
//
// class PostService {
//   final _api = ApiClient();
//
//   /// ---------------------------
//   /// Fetch all posts
//   /// ---------------------------
//   Future<List<dynamic>> fetchPosts() async {
//     final res = await _api.get('/posts', auth: true);
//     return res as List<dynamic>;
//   }
//
//   /// ---------------------------
//   /// Like a post
//   /// ---------------------------
//   Future<void> likePost(String postId) async {
//     await _api.post('/posts/$postId/like', auth: true);
//   }
//
//   /// ---------------------------
//   /// Dislike a post
//   /// ---------------------------
//   Future<void> dislikePost(String postId) async {
//     await _api.post('/posts/$postId/dislike', auth: true);
//   }
//
//   /// ---------------------------
//   /// Add a comment to a post
//   /// ---------------------------
//   Future<void> addComment(String postId, String content) async {
//     await _api.post(
//       '/posts/$postId/comments',
//       body: {"content": content},
//       auth: true,
//     );
//   }
//
//   /// ---------------------------
//   /// Create a new post (used in create.dart)
//   /// ---------------------------
//   Future<Map<String, dynamic>> createPost(String content) async {
//     final res = await _api.post(
//       '/posts',
//       body: {"content": content},
//       auth: true,
//     );
//     return res as Map<String, dynamic>;
//   }
// }


import 'package:hive/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  final SupabaseClient _client = supabase;

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final res = await _client
        .from('posts')
        .select('pid, content, media_url, verification_status, created_at, likes, dislikes, owner:users(uid, full_name, username, profile_pic_url)')
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(res);
  }

  Future<void> likePost(String postId) async {
    await _client
        .from('posts')
        .update({'likes': _client.rpc('increment_likes', params: {'post_id': postId})})
        .eq('pid', postId);
  }

  Future<void> dislikePost(String postId) async {
    await _client
        .from('posts')
        .update({'dislikes': _client.rpc('increment_dislikes', params: {'post_id': postId})})
        .eq('pid', postId);
  }
}
