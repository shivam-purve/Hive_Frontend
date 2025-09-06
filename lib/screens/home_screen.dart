import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  final PostService _postService = PostService();
  final UserService _userService = UserService();

  List<Map<String, dynamic>> _posts = [];
  bool _loading = true;
  final Set<int> _updatingIndexes = {}; // Tracks which posts are updating

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await _postService.fetchPosts();
      if (!mounted) return;

      setState(() {
        _posts = posts.map((p) => {
          "id": p["pid"],
          "profileName": p["authorDisplayName"] ?? p["authorName"] ?? "Unknown",
          "username": p["authorName"] ?? "",
          "profilePic": p["authorAvatar"],
          "verified": p["verified"] ?? false,
          "verificationStatus": p["verificationStatus"] ?? "pending",
          "description": p["content"] ?? "",
          "likes": p["likes"] ?? 0,
          "dislikes": p["dislikes"] ?? 0,
          "isLiked": p["is_liked_by_current_user"] ?? false,
          "isDisliked": false,
          "imageIcon": Icons.article,
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

  Future<void> _toggleLike(int index) async {
    final postId = _posts[index]["id"];

    setState(() {
      _updatingIndexes.add(index);
    });

    try {
      if (_posts[index]["isLiked"]) {
        // If already liked → remove like
        await _userService.dislikePost(postId); // Assuming your API supports toggling like/dislike
        setState(() {
          _posts[index]["isLiked"] = false;
          _posts[index]["likes"] = (_posts[index]["likes"] as int) - 1;
        });
      } else {
        await _userService.likePost(postId);
        setState(() {
          _posts[index]["isLiked"] = true;
          _posts[index]["isDisliked"] = false;
          _posts[index]["likes"] = (_posts[index]["likes"] as int) + 1;
          _posts[index]["dislikes"] =
          (_posts[index]["isDisliked"] ? (_posts[index]["dislikes"] as int) - 1 : _posts[index]["dislikes"]);
        });
      }
    } catch (e) {
      print('Error toggling like: $e');
    } finally {
      setState(() {
        _updatingIndexes.remove(index);
      });
    }
  }

  Future<void> _toggleDislike(int index) async {
    final postId = _posts[index]["id"];

    setState(() {
      _updatingIndexes.add(index);
    });

    try {
      if (_posts[index]["isDisliked"]) {
        // Remove dislike
        await _userService.likePost(postId); // Assuming API supports toggling
        setState(() {
          _posts[index]["isDisliked"] = false;
          _posts[index]["dislikes"] = (_posts[index]["dislikes"] as int) - 1;
        });
      } else {
        await _userService.dislikePost(postId);
        setState(() {
          _posts[index]["isDisliked"] = true;
          _posts[index]["isLiked"] = false;
          _posts[index]["dislikes"] = (_posts[index]["dislikes"] as int) + 1;
          _posts[index]["likes"] =
          (_posts[index]["isLiked"] ? (_posts[index]["likes"] as int) - 1 : _posts[index]["likes"]);
        });
      }
    } catch (e) {
      print('Error toggling dislike: $e');
    } finally {
      setState(() {
        _updatingIndexes.remove(index);
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
            final isUpdating = _updatingIndexes.contains(index);

            return PostCard(
              verificationStatus: post["verificationStatus"],
              profileName: post["profileName"],
              verified: post["verified"],
              description: post["description"],
              imageIcon: post["imageIcon"],
              isLiked: post["isLiked"],
              isDisliked: post["isDisliked"],
              onLike: isUpdating ? null : () => _toggleLike(index),
              onDislike: isUpdating ? null : () => _toggleDislike(index),
              onComment: () {
                Navigator.pushNamed(context, '/comment', arguments: post["id"]);
              },
            );
          },
        ),
      ),
    );
  }
}

