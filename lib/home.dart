
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:social_garbage/screens/create.dart';
import 'package:social_garbage/screens/home_screen.dart';
import 'package:social_garbage/screens/search.dart';
import 'package:social_garbage/screens/notifs.dart';
import 'package:social_garbage/screens/user.dart';

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
    const UserProfilePage()
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
        drawer: Drawer(
          backgroundColor: Colors.white,
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: screenList,
        ),
        appBar: AppBar(
          scrolledUnderElevation: 0,
            leading: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left : 13.0),
                child: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/menu_bar.png')),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            title: Text("Hive",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700
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
                  label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/icons/compass.png')),
                  label: "Navigate"
              ),
              BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/icons/plus.png')),
                  label: "Create"
              ),
              BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/icons/bell.png')),
                  label: "Notifs"
              ),
              BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/icons/user.png')),
                  label: "User"
              ),

            ],
          ),
        )
    );
  }

}

