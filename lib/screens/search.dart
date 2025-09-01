
import 'package:flutter/material.dart';

import '../colors_theme/color.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  // Mock Data
  final List<Map<String, dynamic>> _posts = [
    {
      "username": "TechGuru",
      "content": "Flutter makes cross-platform apps so easy! 🚀",
      "status": "Safe"
    },
    {
      "username": "Troll123",
      "content": "This platform is useless 😂",
      "status": "Flagged"
    },
    {
      "username": "AI_Fan",
      "content": "AI is revolutionizing the world, stay updated!",
      "status": "Safe"
    },
    {
      "username": "ReviewBot",
      "content": "This comment is under manual check.",
      "status": "Under Review"
    },
    {
      "username": "SpammerGuy",
      "content": "Click here for FREE money 💸 scam-link.com",
      "status": "Flagged"
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredPosts {
    String query = _searchController.text.toLowerCase();
    return _posts.where((post) {
      bool matchesQuery = post["username"].toLowerCase().contains(query) ||
          post["content"].toLowerCase().contains(query);

      bool matchesFilter = (_filter == "All") || (post["status"] == _filter);

      return matchesQuery && matchesFilter;
    }).toList();
  }

  void _setFilter(String filter) {
    setState(() {
      _filter = filter;
    });
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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Search Posts",
            style: TextStyle(fontWeight: FontWeight.bold)),
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
              onChanged: (_) => setState(() {}),
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
              child: _filteredPosts.isEmpty
                  ? const Center(
                child: Text("No results found 🔍",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              )
                  : ListView.builder(
                itemCount: _filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = _filteredPosts[index];
                  return Card(
                    shadowColor: Colors.transparent,
                    color: AppColors.primary_light,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _statusColor(post["status"]),
                        child: Text(
                          post["username"][0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(post["username"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post["content"]),
                          const SizedBox(height: 4),
                          Text(
                            post["status"],
                            style: TextStyle(
                              color: _statusColor(post["status"]),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
