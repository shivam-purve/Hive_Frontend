
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _User();
}

class _User extends State<User>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [Text("User")],
        ),
      ),
    );
  }

}