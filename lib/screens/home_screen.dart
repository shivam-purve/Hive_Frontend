import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  
  final List<Map<String, dynamic>> _posts = [
    {
      "profileName": "OpenAI",
      "verified": true,
      "description": "Turn Ideas Into Images with ChatGPT. Describe anything - like “Dhruv sitting in Library” and watch it appear. Try it out!",
      "imagePath": "assets/chatgpt.png",
    },
    {
      "profileName": "Reddit",
      "verified": false,
      "description": "Watch out my newly Launched series, with much more comedy only on Amazon Prime, Netflix and Disney+ Hotstar!",
      "imagePath": "assets/reddit.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Social Trash",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.people_alt_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                
                itemCount: 1000,
                itemBuilder: (context, index) {
                  
                  final post = _posts[index % _posts.length];
                  return postCard(
                    profileName: post["profileName"],
                    verified: post["verified"],
                    description: post["description"],
                    imagePath: post["imagePath"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget postCard({
    required String profileName,
    required bool verified,
    required String description,
    required String imagePath,
  }) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.thumb_up_alt_outlined, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Say Something...",
                        hintStyle: const TextStyle(fontSize: 13),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey.shade300),
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
