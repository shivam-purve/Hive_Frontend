import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../services/user_service.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with AutomaticKeepAliveClientMixin<UserProfilePage> {
  @override
  bool get wantKeepAlive => true;

  final UserService _userService = UserService();

  Map<String, dynamic>? _user;
  List<Map<String, dynamic>> _posts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _userService.getCurrentUser();
      final posts = await _userService.getUserPosts(user['id'].toString());
      if (!mounted) return;
      setState(() {
        _user = user;
        _posts = posts
            .map<Map<String, dynamic>>((p) => {
          "id": p["id"],
          "profileName": user["name"] ?? "User",
          "verified": p["verified"] ?? false,
          "description": p["content"] ?? "",
          "imageIcon": Icons.article,
          "isLiked": false,
          "isDisliked": false,
        })
            .toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load user data: $e")),
      );
    }
  }

  void _toggleLike(int index) async {
    final postId = _posts[index]["id"];
    setState(() {
      _posts[index]["isLiked"] = !_posts[index]["isLiked"];
      _posts[index]["isDisliked"] = false;
    });

    try {
      await _userService.likePost(postId);
    } catch (_) {
      setState(() {
        _posts[index]["isLiked"] = !_posts[index]["isLiked"];
      });
    }
  }

  void _toggleDislike(int index) async {
    final postId = _posts[index]["id"];
    setState(() {
      _posts[index]["isDisliked"] = !_posts[index]["isDisliked"];
      _posts[index]["isLiked"] = false;
    });

    try {
      await _userService.dislikePost(postId);
    } catch (_) {
      setState(() {
        _posts[index]["isDisliked"] = !_posts[index]["isDisliked"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data found")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _user?['avatar'] != null
                        ? NetworkImage(_user!['avatar'])
                        : const AssetImage("assets/icons/user.png")
                    as ImageProvider,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StatColumn(
                          label: "Posts",
                          count: _posts.length.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bio Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_user?['name'] ?? "Unknown",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(_user?['bio'] ?? "This user has no bio."),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // User Posts
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return PostCard(
                  profileName: post["profileName"],
                  verified: post["verified"],
                  description: post["description"],
                  imageIcon: post["imageIcon"],
                  isLiked: post["isLiked"],
                  isDisliked: post["isDisliked"],
                  onLike: () => _toggleLike(index),
                  onDislike: () => _toggleDislike(index),
                  onComment: () {
                    Navigator.pushNamed(context, '/comment',
                        arguments: post["id"]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String count;

  const _StatColumn({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label),
      ],
    );
  }
}
