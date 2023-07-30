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
import 'package:uroapplication/view/admin/login.dart';
import 'package:uroapplication/view/patient/settings.dart';

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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreenPatient()));
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
    final subheading1 = screenWidth * 0.07 * textScaleFactor;
    final subheading2 = screenWidth * 0.06 * textScaleFactor;
    final subheading3 = screenWidth * 0.06 * textScaleFactor;

    final heading = screenWidth * 0.09 * textScaleFactor;

    // final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
      ),
      body: Column(
        children: [
          Text(
            "Account",
            style: TextStyle(
                fontSize: heading,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Card(
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.13,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: subheading3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          thickness: 0.3,
                          color: Colors.grey,
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: subheading3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: blue,
                child: Container(
                  height: screenHeight * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Share Your Story",
                          style: TextStyle(
                              fontSize: subheading3, color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
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
                            color: Colors.pink,
                          ),
                          title: Text(
                            "Settings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: subheading3,
                                color: Colors.black),
                          ),
                          trailing: Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.pink,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 0.3,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.cloud_download,
                            color: Colors.pink,
                          ),
                          title: Text(
                            "Download Your Record",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: subheading3,
                                color: Colors.black),
                          ),
                          trailing: Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.pink,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                child: Container(
                  height: screenHeight * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 00),
                    child: ListTile(
                      onTap: () {
                        signOut();
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.pink,
                      ),
                      title: Text(
                        "LogOut Your Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: subheading3,
                            color: Colors.black),
                      ),
                      trailing: Icon(
                        CupertinoIcons.right_chevron,
                        color: Colors.pink,
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
