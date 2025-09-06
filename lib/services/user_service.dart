// lib/services/user_service.dart
import 'package:flutter/foundation.dart';

import '../main.dart';
import 'api_client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';


class UserService {
  Future<Map<String, int>> likePost(String postId) async {
    final session = supabase.auth.currentSession;
    final jwt = session?.accessToken;

    if (jwt == null) throw Exception('No Supabase session found.');

    final url = Uri.parse('$kBaseUrl/post/$postId/like');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "likes": data['likes'],         // Updated like count
        "dislikes": data['dislikes'],   // Updated dislike count
      };
    } else {
      throw Exception('Failed to like post: ${response.body}');
    }
  }

  Future<Map<String, int>> dislikePost(String postId) async {
    final session = supabase.auth.currentSession;
    final jwt = session?.accessToken;

    if (jwt == null) throw Exception('No Supabase session found.');

    final url = Uri.parse('$kBaseUrl/post/$postId/dislike');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "likes": data['likes'],         // Updated like count
        "dislikes": data['dislikes'],   // Updated dislike count
      };
    } else {
      throw Exception('Failed to dislike post: ${response.body}');
    }
  }


  Future<Map<String, dynamic>> getCurrentUser() async {
    final session = supabase.auth.currentSession;
    final jwt = session?.accessToken;

    if (jwt == null) {
      throw Exception("No Supabase session found. User not logged in.");
    }

    final url = Uri.parse('$kBaseUrl/user/me');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $jwt",
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("✅ ${response.body}");
      }
      return json.decode(response.body) as Map<String, dynamic>;

    } else {
      throw Exception('Failed to load current user: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getUserPosts(String uid) async {
    final session = supabase.auth.currentSession;
    final jwt = session?.accessToken;

    if (jwt == null) {
      throw Exception("No Supabase session found. User not logged in.");
    }

    final url = Uri.parse('$kBaseUrl/post/users/$uid/posts');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $jwt",
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map<Map<String, dynamic>>((post) => {
        // Core post info
        "pid": post["pid"] ?? "",
        "content": post["content"] ?? "",

        // Author info
        "authorName": post["author_name"] ?? "",
        "authorDisplayName": post["author_display_name"],
        "authorAvatar": post["author_avatar"],

        // Engagement
        "likes": post["likes"] ?? 0,
        "dislikes": post["dislikes"] ?? 0,
        "score": post["score"] ?? 0,
        "commentsCount": post["comments_count"] ?? 0,
        "isLikedByCurrentUser": post["is_liked_by_current_user"] ?? false,

        // Context
        "communityId": post["community_id"],
        "communityName": post["community_name"],
        "tags": (post["tags"] as List<dynamic>?)
            ?.map((tag) => tag.toString())
            .toList() ??
            [],

        // Verification
        "verified": post["verification_status"] == "verified",

        // Timestamp
        "createdAt": post["created_at"] ?? "",
      }).toList();
    } else {
      throw Exception(
        'Failed to load user posts: ${response.statusCode} + ${response.body}',
      );
    }
  }
}



/// Logs out the current user by calling your backend's /user/logout endpoint.
Future<void> logoutUser() async {
  try {
    // 1. Get Supabase JWT
    final session = supabase.auth.currentSession;
    final jwt = session?.accessToken;

    if (jwt == null) {
      throw Exception("No Supabase session found. User not logged in.");
    }

    // 2. Call your backend logout endpoint
    final response = await http.get(
      Uri.parse("$kBaseUrl/user/logout"),
      headers: {
        "Authorization": "Bearer $jwt",
        "Content-Type": "application/json",
      },
    );

    // 3. Handle response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("✅ ${data['message']}");

      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'com.hive://login-callback', // Optionally set the redirect link to bring back the user via deeplink.
        authScreenLaunchMode:
        kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
      );
    } else {
      throw Exception(
        "❌ Logout failed: ${response.statusCode} ${response.body}",
      );
    }
  } catch (e) {
    print("⚠️ Error during logout: $e");
    rethrow;
  }
}


