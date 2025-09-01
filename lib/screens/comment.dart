import 'package:flutter/material.dart';

import '../colors_theme/color.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> with AutomaticKeepAliveClientMixin<Comment> {
  @override
  bool get wantKeepAlive => true;
  final List<Map<String, dynamic>> _comments = [
    {
      "author": "TechExpert",
      "text": "This is a great idea to filter out unwanted content!",
      "isLiked": false,
      "isDisliked": false,
    },
    {
      "author": "SpammerGuy",
      "text": "Check out my new product! Click here -> fake-link.com",
      "isLiked": false,
      "isDisliked": false,
    },
    {
      "author": "CommunityUser",
      "text": "I think this will make social media a much better place.",
      "isLiked": false,
      "isDisliked": false,
    },
  ];

  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreOnScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _loadMoreOnScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMoreComments();
    }
  }

  void _loadMoreComments() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);

    await Future.delayed(const Duration(seconds: 2)); // simulate API delay

    List<Map<String, dynamic>> newComments = List.generate(5, (i) {
      int userNum = _comments.length + i + 1;
      return {
        "author": "User$userNum",
        "text": "This is an auto-loaded comment from User$userNum",
        "isLiked": false,
        "isDisliked": false,
      };
    });

    setState(() {
      _comments.addAll(newComments);
      _isLoadingMore = false;
    });
  }

  void _onLikeTapped(int index) {
    setState(() {
      _comments[index]["isLiked"] = !_comments[index]["isLiked"];
      _comments[index]["isDisliked"] = false;
    });
  }

  void _onDislikeTapped(int index) {
    setState(() {
      _comments[index]["isDisliked"] = !_comments[index]["isDisliked"];
      _comments[index]["isLiked"] = false;
    });
  }

  void _sendComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.insert(0, {
          "author": "You",
          "text": _commentController.text.trim(),
          "isLiked": false,
          "isDisliked": false,
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Comments",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(

                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _comments.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _comments.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final comment = _comments[index];
                  return CommentCard(
                    key: ValueKey(index),
                    index: index,
                    author: comment["author"],
                    text: comment["text"],
                    isLiked: comment["isLiked"],
                    isDisliked: comment["isDisliked"],
                    onLike: () => _onLikeTapped(index),
                    onDislike: () => _onDislikeTapped(index),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 240, 240, 240),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendComment,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Icon(Icons.send,
                          color: AppColors.primary, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// COMMENT CARD WIDGET

class CommentCard extends StatelessWidget {
  final int index;
  final String author;
  final String text;
  final bool isLiked;
  final bool isDisliked;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const CommentCard({
    super.key,
    required this.index,
    required this.author,
    required this.text,
    required this.isLiked,
    required this.isDisliked,
    required this.onLike,
    required this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.black54),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(author,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(text, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onLike,
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 16,
                            color: isLiked ? Colors.blue : Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: onDislike,
                          child: Icon(
                            Icons.thumb_down_alt_outlined,
                            size: 16,
                            color: isDisliked ? Colors.red : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
