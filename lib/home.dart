
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
  final int _safePercent = 89;
  final int _underReviewPercent = 10;
  late final int _flaggedPecentage = 100 - _safePercent - _underReviewPercent;
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
    return Scaffold(
        endDrawer: Drawer(
          backgroundColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height : 60),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                  child: Row(
                    children: [
                      ImageIcon(AssetImage(
                          'assets/icons/brain.png'),
                      size : 30,
                      color: Color.fromARGB(255, 254, 198, 41),),
                      const SizedBox(width: 20),
                      Text("AI Content Filter Engine",
                      style: GoogleFonts.redditSans(
                        fontSize : 17,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 2,
                  color: Color.fromARGB(255, 215, 215, 215),
                ),
                Container(
                  height: 200,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(43, 254, 198, 41),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ImageIcon(AssetImage(
                                  'assets/icons/information.png'),
                                size : 35,
                                color: Color.fromARGB(255, 254, 198, 41),),
                              const SizedBox(width: 15),
                              Text("Content Safety",
                                style: GoogleFonts.redditSans(
                                  fontSize : 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            ]
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Safe Content",
                                  style: GoogleFonts.redditSans(
                                    fontSize : 17,
                                    color: Color.fromARGB(255, 0, 171, 74),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text("$_safePercent" "%",
                                  style: GoogleFonts.redditSans(
                                    fontSize : 17,
                                    color: Color.fromARGB(255, 0, 171, 74),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]
                          ),
                          const SizedBox(height: 12.5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Under Review",
                                  style: GoogleFonts.redditSans(
                                    fontSize : 17,
                                    color: Color.fromARGB(255, 181, 144, 30),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text("$_underReviewPercent" "%",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.redditSans(
                                    fontSize : 17,
                                    color: Color.fromARGB(255, 181, 144, 30),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]
                          ),
                          const SizedBox(height: 12.5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Flagged Content",
                                  style: GoogleFonts.redditSans(
                                    fontSize : 17,
                                    color: Color.fromARGB(255, 224, 62, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text("$_flaggedPecentage" "%",
                                  style: GoogleFonts.redditSans(
                                    fontSize : 17,
                                    color: Color.fromARGB(255, 224, 62, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]
                          ),
                          const SizedBox(height: 10,),
                          Text("Real-Time Update from Post Content",
                            style: GoogleFonts.redditSans(
                              fontSize : 8,
                              color: Color.fromARGB(255, 112, 112, 112),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                    ),
                  )
                ),
                const Divider(
                  thickness: 2,
                  color: Color.fromARGB(255, 215, 215, 215),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 20,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(43, 254, 198, 41),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 190,
                          child: TextFormField(
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black,
                              hint: Text("Enter your Text Here to check...",
                                style: GoogleFonts.redditSans(
                                  color: Color.fromARGB(255, 81, 81, 81),
                                  fontSize: 13,
                                ),),
                            ),
                            //TODO - Add the Controller Support Here
                            controller: TextEditingController(),
                            style: GoogleFonts.redditSans(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: IconButton(
                            icon: ImageIcon(AssetImage(
                                'assets/icons/send.png'),
                              size : 25,
                              color: Color.fromARGB(255, 254, 198, 41),),
                            //TODO - Implement the Button Mechanism
                            onPressed: () {  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 20)
              ]
            )
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
            title: Text("Hive",
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

