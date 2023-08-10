// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/view/calculator/quiz2_screen.dart';
import 'package:uroapplication/view/calculator/quiz_screen.dart';
import '../../controller/mycolors.dart';

import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class OABScreen extends StatefulWidget {
  @override
  State<OABScreen> createState() => _OABScreenState();
}

class _OABScreenState extends State<OABScreen> {
  bool isFinished = false;

  final userId = FirebaseAuth.instance.currentUser!.uid;
  int check = 0;
  String name = "loading....";
  String email = "loading....";
  String phone = 'loading....';

  void getInfo() async {
    var collection = FirebaseFirestore.instance.collection('Patients');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        email = data?["Email"];
        //phone = data?["Phone"];
      });
    }
    print(userId);
  }

  // int _currentIndex = 0;

  // final List<Widget> _screens = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading = screenWidth * 0.06 * textScaleFactor;
    final heading = screenWidth * 0.08 * textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [skyblue, darkblue],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.09,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Health Test: Quick Assessment for Vital Indicators.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: subheading, color: Colors.white),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: screenHeight / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2)),
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        height: screenHeight / 7,
                        width: screenWidth,
                        image: AssetImage('assets/images/1.png'),
                      ),
                      Text(
                        "OAB Diagnosis",
                        style: TextStyle(
                            fontSize: heading,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: SwipeableButtonView(
                  //     buttonText: 'Start OAB Diagnosis',
                  //     buttonWidget: Container(
                  //       child: Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     activeColor: Colors.white.withOpacity(0.2),
                  //     isFinished: isFinished,
                  //     onWaitingProcess: () {
                  //       Future.delayed(Duration(seconds: 2), () {
                  //         setState(() {
                  //           isFinished = true;
                  //         });
                  //       });
                  //     },
                  //     onFinish: () async {
                  //       await Navigator.push(
                  //           context,
                  //           PageTransition(
                  //               type: PageTransitionType.fade, child: OAB()));

                  //       //TODO: For reverse ripple effect animation
                  //       setState(() {
                  //         isFinished = false;
                  //       });
                  //     },
                  //   ),
                  // )
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OAB()));
                  }, child: Text("Take OAB Quiz"))
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          //quiz2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: screenHeight / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2)),
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        height: screenHeight / 7,
                        width: screenWidth,
                        image: AssetImage('assets/images/2.png'),
                      ),
                      Text(
                        "IPSS Diagnosis",
                        style: TextStyle(
                            fontSize: heading,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: SwipeableButtonView(
                  //     buttonText: 'Start IPSS Diagnosis',
                  //     buttonWidget: Container(
                  //       child: Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     activeColor: Colors.white.withOpacity(0.2),
                  //     isFinished: isFinished,
                  //     onWaitingProcess: () {
                  //       Future.delayed(Duration(seconds: 2), () {
                  //         setState(() {
                  //           isFinished = true;
                  //         });
                  //       });
                  //     },
                  //     onFinish: () async {
                  //       await Navigator.push(
                  //           context,
                  //           PageTransition(
                  //               type: PageTransitionType.fade, child: IPSS()));

                  //       //TODO: For reverse ripple effect animation
                  //       setState(() {
                  //         isFinished = false;
                  //       });
                  //     },
                  //   ),
                  // )
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => IPSS()));
                  }, child: Text("Take IPSS Quiz"))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
