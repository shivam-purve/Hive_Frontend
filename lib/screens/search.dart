
// lib/screens/search.dart
import 'package:flutter/material.dart';
import '../colors_theme/color.dart';
import '../services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _searchController = TextEditingController();

  final SearchService _searchService = SearchService();
  List<Map<String, dynamic>> _posts = [];
  bool _loading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() => _loading = true);
    try {
      final results = await _searchService.searchPosts(
        query: _searchController.text,
      );
      setState(() => _posts = results); // results is List<Map<String, dynamic>>
    } catch (e) {
      if (!mounted) return;
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Search Posts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: (_) => _performSearch(),
              decoration: InputDecoration(
                hintText: "Search usernames or posts...",
                prefixIcon: const Icon(Icons.search, color: Colors.amber),
                filled: true,
                fillColor: const Color.fromARGB(30, 255, 193, 7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Removed filter row

            // Results
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _posts.isEmpty
                  ? const Center(
                child: Text(
                  "No results found 🔍",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
                  : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final user = _posts[index];
                  return Card(
                    color: AppColors.primary_light,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 3),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name column
                          Expanded(
                            flex: 2,
                            child: Text(
                              user["full_name"] ?? "Unknown",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              softWrap: true,
                            ),
                          ),

                          // Email column
                          Expanded(
                            flex: 3,
                            child: Text(
                              user["email"] ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              softWrap: true,
                            ),
                          ),

                          // Bio column
                          Expanded(
                            flex: 4,
                            child: Text(
                              user["bio"] ?? "",
                              style: const TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
