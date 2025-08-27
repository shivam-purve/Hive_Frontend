import 'package:flutter/material.dart';

import '../colors_theme/color.dart';

Widget postCard({
  required BuildContext context,
  required String profileName,
  required bool verified,
  required String description,
  required IconData imageIcon,
}) {
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
                          verified ? "Verified & Safe" : "Unverified Info",
                          style: TextStyle(
                            fontSize: 12,
                            color: verified ? Colors.green : Colors.orange,
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
              description,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => _onLikeTapped(index),
                    child: Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 20,
                      color: isLiked ? Colors.blue : Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _onDislikeTapped(index),
                    child: Icon(
                      Icons.thumb_down_alt_outlined,
                      size: 20,
                      color: isDisliked ? Colors.red : Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
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
                  // child: TextField(
                  //   decoration: InputDecoration(
                  //     hintText: "Say Something...",
                  //     hintStyle: TextStyle(fontSize: 13),
                  //     isDense: true,
                  //     contentPadding: EdgeInsets.symmetric(
                  //         horizontal: 10, vertical: 8),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(25)),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //     filled: true,
                  //     fillColor: Color.fromARGB(255, 240, 240, 240),
                  //   ),
                  // ),
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
