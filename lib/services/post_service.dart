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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/main.dart';
import 'package:hive/services/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/services/post_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class PostService {
  /// Ensure valid Supabase session
  Future<String?> _getValidJwt() async {
    final client = Supabase.instance.client;
    var session = client.auth.currentSession;

    if (session == null) {
      throw Exception("No Supabase session found. Please log in again.");
    }

    // Refresh session if close to expiry
    final expiresAt = session.expiresAt;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (expiresAt != null && expiresAt <= now + 60) {
      final res = await client.auth.refreshSession();
      session = res.session;
      if (session == null) {
        throw Exception("Failed to refresh session. Please log in again.");
      }
    }

    return session.accessToken;
  }

  /// Fetch all posts for Home feed
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final jwt = await _getValidJwt();
    final url = Uri.parse('$kBaseUrl/post/');

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $jwt",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map<Map<String, dynamic>>((post) {
        return {
          "pid": post["pid"] ?? "",
          "content": post["content"] ?? "",
          "authorName": post["author_name"] ?? "",
          "authorDisplayName": post["author_display_name"] ?? "",
          "authorAvatar": post["author_avatar"] ?? "",
          "likes": post["likes"] ?? 0,
          "dislikes": post["dislikes"] ?? 0,
          "score": post["score"] ?? 0,
          "commentsCount": post["comments_count"] ?? 0,
          "isLikedByCurrentUser": post["is_liked_by_current_user"] ?? false,
          "communityId": post["community_id"],
          "communityName": post["community_name"],
          "tags": post["tags"] ?? [],
          "verified": post["verification_status"] == "verified",
          "createdAt": post["created_at"] ?? "",
        };
      }).toList();
    } else {
      throw Exception(
        "Failed to fetch posts: ${response.statusCode} → ${response.body}",
      );
    }
  }

  /// Like post
  Future<void> likePost(String postId) async {
    final jwt = await _getValidJwt();
    final url = Uri.parse('$kBaseUrl/post/$postId/like');

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $jwt",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to like post: ${response.body}");
    }
  }

  /// Dislike post
  Future<void> dislikePost(String postId) async {
    final jwt = await _getValidJwt();
    final url = Uri.parse('$kBaseUrl/post/$postId/dislike');

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $jwt",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to dislike post: ${response.body}");
    }
  }
}





