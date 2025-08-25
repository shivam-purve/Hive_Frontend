
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
      ),
      appBar: AppBar(
        title: Text("Social Garbage",
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w500
        ),),
        backgroundColor: Colors.transparent
      ),
    );
  }

}