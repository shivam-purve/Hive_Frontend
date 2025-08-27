
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _Navigation();
}

class _Navigation extends State<Navigation>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [Text("Navigation")],
        ),
      ),
    );
  }

}