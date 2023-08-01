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

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    // final subheading1 = screenWidth * 0.07 * textScaleFactor;
   // final subheading2 = screenWidth * 0.06 * textScaleFactor;
    final subheading3 = screenWidth * 0.06 * textScaleFactor;

    final heading = screenWidth * 0.09 * textScaleFactor;

    // final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Text(
            "Settings",
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
                color: Colors.white,
                child: Container(
                  height: screenHeight * 0.16,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 00),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.language,
                            color: Colors.pink,
                          ),
                          title: Text(
                            "Language",
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
                            CupertinoIcons.color_filter,
                            color: Colors.pink,
                          ),
                          title: Text(
                            "Switch Theme",
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
              )
            ]),
          )
        ],
      ),
    );
  }
}
