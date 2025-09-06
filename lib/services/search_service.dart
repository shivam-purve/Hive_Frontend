import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchService {
  final String baseUrl = "https://hive-backend-tnmw.onrender.com";

  Future<List<Map<String, dynamic>>> searchPosts({
    required String query,
    String? status,
  }) async {
    if (query.trim().isEmpty) {
      throw Exception("Query cannot be empty.");
    }

    // 1. Get Supabase JWT
    final session = Supabase.instance.client.auth.currentSession;
    final jwt = session?.accessToken;
    if (jwt == null) {
      throw Exception("No Supabase session found. User not logged in.");
    }

    // 2. Build request
    final response = await http.get(
      Uri.parse("$baseUrl/user/search?name=$query"),
      headers: {
        "Authorization": "Bearer $jwt",
        "Accept": "application/json",
      },
    );

    // 3. Handle response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception("Invalid response format.");
      }
    } else if (response.statusCode == 400) {
      throw Exception("Bad Request: query cannot be empty.");
    } else if (response.statusCode == 404) {
      throw Exception("No users found for '$query'.");
    } else {
      throw Exception(
        "Unexpected error: ${response.statusCode} ${response.body}",
      );
    }
  }
}
