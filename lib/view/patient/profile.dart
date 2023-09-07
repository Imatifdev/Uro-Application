// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uroapplication/controller/mycolors.dart';
import 'package:uroapplication/view/patient/historypage.dart';
import 'package:uroapplication/view/patient/settings.dart';
import 'package:uroapplication/view/splash.dart';
import 'package:uroapplication/view/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../widgets/custombutton.dart';
import 'login.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    print('object');
    await auth.signOut();
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginScreenPatient()));
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  int check = 0;
  String name = "loading....";
  String email = "loading....";
  String phone = 'loading....';
  String dob = 'DD-MM-YYYY';

  void getInfo() async {
    var collection = FirebaseFirestore.instance.collection('Patients');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        email = data?["Email"];
        dob = data?['DOB'];
        phone = data?['Phone'];

        //phone = data?["Phone"];
      });
    }
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    // final subheading1 = screenWidth * 0.07 * textScaleFactor;
    // final subheading2 = screenWidth * 0.06 * textScaleFactor;
    final subheading3 = screenWidth * 0.04 * textScaleFactor;

    final heading = screenWidth * 0.07 * textScaleFactor;

    // final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Color(0xff0047ba),
      appBar: AppBar(
        backgroundColor: Color(0xff0047ba),
        toolbarHeight: screenHeight * 0.09,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 80,
          color: Colors.white,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.left_chevron),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Text(                  AppLocalizations.of(context)!.account,

            style: TextStyle(
                fontSize: heading,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Card(
                color: button,
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: subheading3,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          thickness: 0.3,
                          color: Colors.white,
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: subheading3,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: button,
                child: Container(
                  height: screenHeight * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.sharestory,
                          style: TextStyle(
                            fontSize: subheading3,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          color: button,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: button,
                child: Container(
                  height: screenHeight * 0.16,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 00),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SettingsScreen(),
                                ));
                          },
                          leading: Icon(
                            CupertinoIcons.settings_solid,
                            color: Colors.yellow,
                          ),
                          title: Text(
                          AppLocalizations.of(context)!.settings,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: subheading3,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.yellow,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 0.3,
                            color: Colors.white,
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: HistoryPage(),
                                ));
                          },
                          leading: Icon(
                            CupertinoIcons.cloud_download,
                            color: Colors.yellow,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.download,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: subheading3,
                                color: Colors.white),
                          ),
                          trailing: Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.yellow,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: button,
                child: Container(
                  height: screenHeight * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 00),
                    child: ListTile(
                      onTap: () async {
                        signOut();
                        await Navigator.of(context).push(
                           MaterialPageRoute(builder: (context)=> SplashScreen()) 
                        );

                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.yellow,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.logout,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: subheading3,
                            color: Colors.white),
                      ),
                      trailing: Icon(
                        CupertinoIcons.right_chevron,
                        color: Colors.yellow,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
