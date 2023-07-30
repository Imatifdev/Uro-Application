// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/controller/mycolors.dart';
import 'package:uroapplication/view/admin/login.dart';

import '../../widgets/custombutton.dart';

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
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      backgroundColor: skyblue,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [skyblue, blue, darkblue],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  color: skyblue.withOpacity(0.2),
                  child: Container(
                    height: screenHeight / 1.5,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              CupertinoIcons.profile_circled,
                              size: 100,
                              color: pink,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Patient Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: heading,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Patient Name: $name",
                            style: TextStyle(
                                color: Colors.white, fontSize: subheading2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Email: $email",
                            style: TextStyle(
                                color: Colors.white, fontSize: subheading2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Contact: $phone",
                            style: TextStyle(
                                color: Colors.white, fontSize: subheading2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Date of Birth: $dob",
                            style: TextStyle(
                                color: Colors.white, fontSize: subheading2),
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Center(
                            child: Container(
                              height: screenHeight * 0.05,
                              width: screenWidth / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login_outlined,
                                    color: pink,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "LogOut",
                                    style: TextStyle(
                                        fontSize: subheading3, color: pink),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
