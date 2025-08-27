import 'package:flutter/material.dart';
import 'package:social_garbage/screens/comment.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          '/comment': (context) => const Comment(),
        },
      home: Home()
    );
  }
}


