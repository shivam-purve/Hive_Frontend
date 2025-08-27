//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class User extends StatefulWidget {
//   const User({super.key});
//
//   @override
//   State<User> createState() => _User();
// }
//
// class _User extends State<User>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           children: [Text("User")],
//         ),
//       ),
//     );
//   }
//
// }

import 'package:flutter/material.dart';

import '../widgets/post_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram User Page",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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

  // Example post images (replace with backend API / DB later)
  final List<String> posts = List.generate(
      15, (index) => "https://picsum.photos/id/${index + 50}/200/200");

  final String user_name = "Mritunjay Tiwari";

  @override
  Widget build(BuildContext context) {
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
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _StatColumn(label: "Posts", count: "10"),
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
                    Text("$user_name",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text("This is a short bio of the user."),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _posts.length * 10,
              itemBuilder: (context, index) {
                final post = _posts[index % _posts.length];
                return postCard(
                  context : context,
                  profileName: post["profileName"],
                  verified: post["verified"],
                  description: post["description"],
                  imageIcon: post["imageIcon"],
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