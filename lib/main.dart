import 'package:flutter/material.dart';
import 'package:social_garbage/screens/comment.dart';

import 'home.dart';
import 'notifs/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Init notifications
  NotiService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          '/comment': (context) => const Comment(),
        },
      home: Home()
    );
  }
}


