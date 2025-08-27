

import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _Create();
}

class _Create extends State<Create>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(43, 254, 198, 41),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ImageIcon(AssetImage(
                              'assets/icons/information.png'),
                            size : 35,
                            color: Color.fromARGB(255, 254, 198, 41),),
                          SizedBox(width: 15),
                          Text("Content Safety",
                            style: TextStyle(
                              fontSize : 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ]
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Safe Content",
                              style: TextStyle(
                                fontSize : 17,
                                color: Color.fromARGB(255, 0, 171, 74),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("test" "%",
                              style: TextStyle(
                                fontSize : 17,
                                color: Color.fromARGB(255, 0, 171, 74),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 12.5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Under Review",
                              style: TextStyle(
                                fontSize : 17,
                                color: Color.fromARGB(255, 181, 144, 30),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("test" "%",
                              textAlign: TextAlign.right,
                              style: TextStyle(
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
                              style: TextStyle(
                                fontSize : 17,
                                color: Color.fromARGB(255, 224, 62, 99),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("test" "%",
                              style: TextStyle(
                                fontSize : 17,
                                color: Color.fromARGB(255, 224, 62, 99),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10,),
                      Text("Real-Time Update from Post Content",
                        style: TextStyle(
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
                color: const Color.fromARGB(43, 254, 198, 41),
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          hint: Text("Enter your Text Here to check...",
                            style: TextStyle(
                              color: Color.fromARGB(255, 81, 81, 81),
                              fontSize: 13,
                            ),),
                        ),
                        //TODO - Add the Controller Support Here
                        controller: TextEditingController(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: IconButton(
                        icon: const ImageIcon(AssetImage(
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
            )
          ],
        ),
      ),
    );
  }
  
}