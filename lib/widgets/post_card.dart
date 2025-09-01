import 'package:flutter/material.dart';
import '../colors_theme/color.dart'; 

class PostCard extends StatefulWidget {
  final String profileName;
  final bool verified;
  final String description;
  final IconData imageIcon;

  const PostCard({
    super.key,
    required this.profileName,
    required this.verified,
    required this.description,
    required this.imageIcon, required BuildContext context,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isDisliked = false;

  void _onLikeTapped() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) isDisliked = false;
    });
  }

  void _onDislikeTapped() {
    setState(() {
      isDisliked = !isDisliked;
      if (isDisliked) isLiked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        shadowColor: Colors.transparent,
        color: AppColors.primary_light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.black54),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            widget.verified ? Icons.verified : Icons.info,
                            color: widget.verified ? Colors.green : Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.verified
                                ? "Verified & Safe"
                                : "Unverified Info",
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.verified ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

     
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.description,
                style: const TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                
                  GestureDetector(
                    onTap: _onLikeTapped,
                    child: Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 20,
                      color: isLiked ? Colors.blue : Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),

              
                  GestureDetector(
                    onTap: _onDislikeTapped,
                    child: Icon(
                      Icons.thumb_down_alt_outlined,
                      size: 20,
                      color: isDisliked ? Colors.red : Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/comment');
                        },
                        child: const Text(
                          "Say Something...",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  const Icon(Icons.send_outlined, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
