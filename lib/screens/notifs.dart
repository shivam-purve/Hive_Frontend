
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifs extends StatefulWidget {
  const Notifs({super.key});

  @override
  State<Notifs> createState() => _Notifs();
}

class _Notifs extends State<Notifs>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [Text("notifs")],
        ),
      ),
    );
  }

}