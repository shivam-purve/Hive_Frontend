

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _Create();
}

class _Create extends State<Create>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [Text("Create")],
        ),
      ),
    );
  }
  
}