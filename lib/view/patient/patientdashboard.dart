// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/main.dart';
import 'package:uroapplication/view/patient/historypage.dart';
import 'package:uroapplication/view/patient/oab.dart';
import 'package:uroapplication/view/patient/profile.dart';
import 'package:uroapplication/view/patient/settings.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class PatientDashboard extends StatefulWidget {
  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  bool isFinished = false;
  String selectedLanguage = 'en';
       void changeLocale(value) {
    MyApp.setLocale(context, Locale(value));
  }
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
     showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose a Language'),
            content:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      changeLocale(value);
                      selectedLanguage = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Urdu'),
                  value: 'ur',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    changeLocale(value);
                    setState(() {
                      selectedLanguage = value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  changeLocale("en");
                  Navigator.pop(context);
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.red),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Confirm', style: TextStyle(color: Colors.green),),
              ),
            ],
          );});
          
    });
    super.initState();
  }

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
        backgroundColor: Color(0xff0047ba),
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(),
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
                  AppLocalizations.of(context)!.hello,
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
                        boxShadow: [],
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            height: screenHeight / 6,
                            width: screenWidth,
                            image: AssetImage('assets/images/logo.png'),
                          ),
                          Text(
                            AppLocalizations.of(context)!.miControlAs,
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.15,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.1)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => HistoryPage()));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/history.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            AppLocalizations.of(context)!.viewHis,
                            style: TextStyle(
                                fontSize: subheading1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: screenHeight * 0.15,
                        width: screenWidth / 2.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.1)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => SettingsScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/setting.png',
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.2,
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.settings,
                                  style: TextStyle(
                                      fontSize: subheading2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.15,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.1)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ProfileView()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/newuser.png',
                                  height: screenHeight * 0.08,
                                  width: screenWidth * 0.2,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.profile,
                                  style: TextStyle(
                                      fontSize: subheading2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
