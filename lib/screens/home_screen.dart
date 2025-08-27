import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      "profileName": "OpenAI",
      "verified": true,
      "description": "Turn Ideas Into Images with ChatGPT. Describe anything - like “Dhruv sitting in Library” and watch it appear. Try it out!",
      "imageIcon": Icons.chat_bubble_outline,
    },
    {
      "profileName": "MrBean",
      "verified": false,
      "description": "Watch out my newly Launched series, with much more comedy only on Amazon Prime, Netflix and Disney+ Hotstar!",
      "imageIcon": Icons.live_tv,
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
                itemCount: _posts.length * 10,
                itemBuilder: (context, index) {
                  final post = _posts[index % _posts.length];
                  return postCard(
                    profileName: post["profileName"],
                    verified: post["verified"],
                    description: post["description"],
                    imageIcon: post["imageIcon"],
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
    required IconData imageIcon,
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
            Container(
              height: 200,
              width: double.infinity,
              color: verified ? Colors.green.shade200 : Colors.blue.shade200,
              child: Center(
                child: Icon(imageIcon, size: 80, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.thumb_up_alt_outlined, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Say Something...",
                        hintStyle: TextStyle(fontSize: 13),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 240, 240, 240),
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
