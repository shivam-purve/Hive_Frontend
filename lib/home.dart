import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hive/screens/create.dart';
import 'package:hive/screens/home_screen.dart';
import 'package:hive/screens/search.dart';
import 'package:hive/screens/notifs.dart';
import 'package:hive/screens/user.dart';
import 'package:hive/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final int _safePercent = 89;
  final int _underReviewPercent = 10;
  late final int _flaggedPecentage = 100 - _safePercent - _underReviewPercent;
  int _selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  List<Widget> screenList = [
    HomeScreen(),
    const SearchScreen(),
    const Create(),
    NotificationsPage(),
    const UserProfilePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(backgroundColor: Colors.white,
      child: ListView(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              try {
                await supabase.auth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                print('Error during logout: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Logout failed: $e")),
                );
              }
            },
          ),
        ],
      ),),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: screenList,
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: IconButton(
              icon: const ImageIcon(AssetImage('assets/icons/menu_bar.png')),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: Text(
          "Hive",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: SizedBox(
        height: 94,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (selectedIndex) {
            setState(() {
              _selectedIndex = selectedIndex;
              _pageController.jumpToPage(selectedIndex);
            });
          },
          type: BottomNavigationBarType.fixed,
          iconSize: 23,
          backgroundColor: Color.fromARGB(255, 254, 198, 41),
          selectedLabelStyle: TextStyle(),
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/icons/compass.png')),
              label: "Navigate",
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/icons/plus.png')),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/icons/bell.png')),
              label: "Notifs",
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('assets/icons/user.png')),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }
}
