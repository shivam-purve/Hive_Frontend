
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_garbage/screens/create.dart';
import 'package:social_garbage/screens/home_screen.dart';
import 'package:social_garbage/screens/navigator.dart';
import 'package:social_garbage/screens/notifs.dart';
import 'package:social_garbage/screens/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 0;
  void _NavigationBottomBar(int index) {
    setState(() {
        _selectedIndex = index;
    });
  }

  List screenList = const [
    HomeScreen(),
    Navigation(),
    Create(),
    Notifs(),
    User()
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        endDrawer: Drawer(

        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
        ),
        body: screenList[_selectedIndex],
        appBar: AppBar(
            actions: [
              Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: IconButton(
                    icon: SvgPicture.asset('assets/icons/ai_filter.svg',
                    height: 30,
                    width: 30,),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ),
            ],
            leading: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left : 13.0),
                child: IconButton(
                  icon: ImageIcon(AssetImage('assets/icons/menu_bar.png')),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            title: Text("Social Trash",
              style: GoogleFonts.redditSans(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700
              ),),
            backgroundColor: Colors.transparent
        ),
        bottomNavigationBar: SizedBox(
          height: 94,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _NavigationBottomBar,
            type: BottomNavigationBarType.fixed,
            iconSize: 23,
            backgroundColor: Color.fromARGB(255, 254, 198, 41),
            selectedLabelStyle: GoogleFonts.redditSans(),
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icons/compass.png')),
                  label: "Navigate"
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icons/plus.png')),
                  label: "Create"
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icons/bell.png')),
                  label: "Notifs"
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icons/user.png')),
                  label: "User"
              ),

            ],
          ),
        )
    );
  }

}

