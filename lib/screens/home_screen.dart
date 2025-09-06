import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../services/post_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  List<Map<String, dynamic>> _posts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await PostService().fetchPosts();
      if (!mounted) return;
      setState(() {
        _posts = posts.map((p) => {
          "id": p["pid"], // post ID
          "profileName": p["authorDisplayName"] ?? p["authorName"] ?? "Unknown",
          "username": p["authorName"] ?? "",
          "profilePic": p["authorAvatar"],
          "verified": p["verified"] ?? false,
          "description": p["content"] ?? "",
          "likes": p["likes"] ?? 0,
          "dislikes": p["dislikes"] ?? 0,
          "isLiked": false,
          "isDisliked": false,
          "imageIcon": Icons.article, // ✅ ensure it's never null
        }).toList();

        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch posts: $e")),
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
      await PostService().likePost(postId);
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
      await PostService().dislikePost(postId);
    } catch (_) {
      setState(() {
        _posts[index]["isDisliked"] = !_posts[index]["isDisliked"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _fetchPosts,
        child: ListView.builder(
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
      ),
    );
  }
}
