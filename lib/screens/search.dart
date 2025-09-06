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
  String _filter = "All";

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
        status: _filter,
      );
      setState(() => _posts = results); // results is List<Map<String, dynamic>>
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Search failed: $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }


  void _setFilter(String filter) {
    setState(() => _filter = filter);
    _performSearch();
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Safe":
        return const Color.fromARGB(255, 0, 171, 74);
      case "Under Review":
        return const Color.fromARGB(255, 181, 144, 30);
      case "Flagged":
        return const Color.fromARGB(255, 224, 62, 99);
      default:
        return Colors.grey;
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

            // Filter row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["All", "Safe", "Under Review", "Flagged"]
                    .map((f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f),
                    selected: _filter == f,
                    onSelected: (_) => _setFilter(f),
                    selectedColor:
                    const Color.fromARGB(255, 254, 198, 41),
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 15),

            // Results
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _posts.isEmpty
                  ? const Center(
                child: Text(
                  "No results found 🔍",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // bigger padding for larger card
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // align text at top
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
