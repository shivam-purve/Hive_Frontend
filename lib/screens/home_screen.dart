//
//
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreen();
// }
//
// class _HomeScreen extends State<HomeScreen>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           children: [Text("Home")],
//         ),
//       ),
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import '../colors_theme/color.dart';
import '../widgets/post_card.dart';

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
  void _onLikeTapped(int index) {
    setState(() {
      _posts[index]["isLiked"] = !_posts[index]["isLiked"];
      _posts[index]["isDisliked"] = false;
    });
  }

  void _onDislikeTapped(int index) {
    setState(() {
      _posts[index]["isDisliked"] = !_posts[index]["isDisliked"];
      _posts[index]["isLiked"] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              thickness : 1,
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
