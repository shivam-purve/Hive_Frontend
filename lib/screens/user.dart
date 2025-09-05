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
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../widgets/post_card.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with AutomaticKeepAliveClientMixin<UserProfilePage> {
  @override
  bool get wantKeepAlive => true;
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
    super.build(context);
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
                    backgroundImage: NetworkImage(googleUser?.photoUrl ?? ""),
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
                  ElevatedButton(onPressed: () async {
                    try {
                      // 1. Sign out from Supabase
                      await Supabase.instance.client.auth.signOut();

                      // 2. Disconnect from Google
                      await googleSignIn.disconnect();

                      // 3. Also sign out from Google session
                      await googleSignIn.signOut();

                      print("Signed out successfully");

                      // 4. Redirect to login screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false, // removes all previous routes
                      );
                    } catch (e) {
                      print("Error during sign out: $e");
                    }
                  }, child: const Text("Sign Out"))
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
                return PostCard(
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