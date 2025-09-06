// import 'package:flutter/material.dart';
// import '../colors_theme/color.dart';
// import '../main.dart';
// import '../services/user_service.dart';
//
// class PostCard extends StatelessWidget {
//   final String profileName;
//   final bool verified;
//   final String description;
//   final IconData imageIcon;
//
//   final bool isLiked;
//   final bool isDisliked;
//
//   final VoidCallback onLike;
//   final VoidCallback onDislike;
//   final VoidCallback onComment;
//
//   const PostCard({
//     super.key,
//     required this.profileName,
//     required this.verified,
//     required this.description,
//     required this.imageIcon,
//     required this.isLiked,
//     required this.isDisliked,
//     required this.onLike,
//     required this.onDislike,
//     required this.onComment,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Card(
//         shadowColor: Colors.transparent,
//         color: AppColors.primary_light,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 1,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Row
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 18,
//                     backgroundColor: Colors.grey[300],
//                     child: const Icon(Icons.person, color: Colors.black54),
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         profileName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             verified ? Icons.verified : Icons.info,
//                             color: verified ? Colors.green : Colors.orange,
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             verified ? "Verified & Safe" : "Unverified Info",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: verified ? Colors.green : Colors.orange,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Description
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Text(
//                 description,
//                 style: const TextStyle(fontSize: 14),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // Actions (like, dislike, comment)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: onLike,
//                     child: Icon(
//                       Icons.thumb_up_alt_outlined,
//                       size: 20,
//                       color: isLiked ? Colors.blue : Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//
//                   GestureDetector(
//                     onTap: onDislike,
//                     child: Icon(
//                       Icons.thumb_down_alt_outlined,
//                       size: 20,
//                       color: isDisliked ? Colors.red : Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: GestureDetector(
//                         onTap: onComment,
//                         child: const Text(
//                           "Say Something...",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//
//                   const Icon(Icons.send_outlined, size: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class PostCardContainer extends StatefulWidget {
//   final Map<String, dynamic> post;
//   final UserService userService;
//
//   const PostCardContainer({
//     super.key,
//     required this.post,
//     required this.userService,
//   });
//
//   @override
//   State<PostCardContainer> createState() => _PostCardContainerState();
// }
//
// class _PostCardContainerState extends State<PostCardContainer> {
//   late bool isLiked;
//   late bool isDisliked;
//   late int likesCount;
//   late int dislikesCount;
//
//   @override
//   void initState() {
//     super.initState();
//     isLiked = widget.post['isLikedByCurrentUser'];
//     isDisliked = false;
//     likesCount = widget.post['likes'];
//     dislikesCount = widget.post['dislikes'];
//   }
//
//   Future<void> _handleLike() async {
//     try {
//       await widget.userService.likePost(widget.post['pid']);
//       setState(() {
//         if (isDisliked) {
//           isDisliked = false;
//           dislikesCount--;
//         }
//         isLiked = !isLiked;
//         likesCount += isLiked ? 1 : -1;
//       });
//     } catch (e) {
//       print('Error liking post: $e');
//     }
//   }
//
//   Future<void> _handleDislike() async {
//     try {
//       await widget.userService.dislikePost(widget.post['pid']);
//       setState(() {
//         if (isLiked) {
//           isLiked = false;
//           likesCount--;
//         }
//         isDisliked = !isDisliked;
//         dislikesCount += isDisliked ? 1 : -1;
//       });
//     } catch (e) {
//       print('Error disliking post: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PostCard(
//       profileName: widget.post['authorDisplayName'] ?? widget.post['authorName'],
//       verified: widget.post['verified'],
//       description: widget.post['content'],
//       imageIcon: Icons.article,
//       isLiked: isLiked,
//       isDisliked: isDisliked,
//       onLike: _handleLike,
//       onDislike: _handleDislike,
//       onComment: () {
//         // Implement comment functionality here
//       },
//     );
//   }
// }
//

import 'package:flutter/material.dart';

import '../colors_theme/color.dart';

class PostCard extends StatelessWidget {
  final String profileName;
  final bool verified;
  final String description;
  final String verificationStatus; // NEW param
  final IconData imageIcon;
  final bool isLiked;
  final bool isDisliked;
  final bool isUpdating;

  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback onComment;

  const PostCard({
    super.key,
    required this.profileName,
    required this.verified,
    required this.description,
    required this.verificationStatus,  // NEW param
    required this.imageIcon,
    required this.isLiked,
    required this.isDisliked,
    required this.onLike,
    required this.onDislike,
    required this.onComment,
    this.isUpdating = false,
  });

  Color _getVerificationColor(String status) {
    switch (status.toLowerCase()) {
      case "verified":
        return Colors.green;
      case "unverified":
        return Colors.orange;
      case "personal_opinion":
        return Colors.blue;
      case "misinformation":
        return Colors.red;
      case "factual_error":
        return Colors.purple;
      case "other":
        return Colors.grey;
      default:
        return Colors.black54;
    }
  }

  String verificationStatusDisplay(String status) {
    switch (status.toLowerCase()) {
      case "verified":
        return "Verified & Safe";
      case "unverified":
        return "Unverified Info";
      case "personal_opinion":
        return "Personal Opinion";
      case "misinformation":
        return "Misinformation";
      case "factual_error":
        return "Factual Error";
      case "other":
        return "Other";
      default:
        return "Unknown Status";
    }
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
            // Profile Row
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
                        profileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            verified ? Icons.verified : Icons.info,
                            color: verified ? Colors.green : Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            verificationStatusDisplay(verificationStatus),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getVerificationColor(verificationStatus),
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

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 8),


            const SizedBox(height: 10),

            // Actions (like, dislike, comment)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  isUpdating
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : GestureDetector(
                    onTap: onLike,
                    child: Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 20,
                      color: isLiked ? Colors.blue : Colors.black54,
                    ),
                  ),

                  const SizedBox(width: 8),

                  isUpdating
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : GestureDetector(
                    onTap: onDislike,
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
                        onTap: onComment,
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

