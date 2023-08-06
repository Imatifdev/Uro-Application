// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/view/patient/oab.dart';
import 'package:uroapplication/view/patient/profile.dart';
import '../../controller/mycolors.dart';

import 'package:page_transition/page_transition.dart';

class PatientDashboard extends StatefulWidget {
  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
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

  //int _currentIndex = 0;

  //final List<Widget> _screens = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading1 = screenWidth * 0.07 * textScaleFactor;
    final subheading2 = screenWidth * 0.06 * textScaleFactor;
    //final subheading3 = screenWidth * 0.06 * textScaleFactor;

    final heading = screenWidth * 0.08 * textScaleFactor;
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }

    return Scaffold(
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                      fontSize: subheading1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.person_alt_circle,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ProfileView(),
                        ));
                  },
                )
              ],
            ),
            Text(
              "$name \u{1F44B}",
              style: TextStyle(
                  fontSize: subheading2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            InkWell(
              onTap: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(seconds: 2),
                      type: PageTransitionType.fade,
                      child: OABScreen(),
                    ));
              },
              child: Container(
                height: screenHeight / 3,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Image(
                      height: screenHeight / 6,
                      width: screenWidth,
                      image: AssetImage('assets/images/health.png'),
                    ),
                    Text(
                      "Urinary Function Assessment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: heading,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
