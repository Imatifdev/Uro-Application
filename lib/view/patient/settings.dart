// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/controller/mycolors.dart';
import 'package:uroapplication/view/patient/forgot.dart';
import 'package:uroapplication/view/patient/language_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../main.dart';
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

    final subheading3 = screenWidth * 0.06 * textScaleFactor;

    final heading = screenWidth * 0.09 * textScaleFactor;

    // final controller = Get.put(ProfileController());
    return Scaffold(
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
      backgroundColor: Color(0xff0047ba),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Text(
            AppLocalizations.of(context)!.settings,
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
                  height: screenHeight * 0.16,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 00),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // You can customize the border style
                            borderRadius: BorderRadius.circular(
                                8), // You can adjust the border radius
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LanguageScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: subheading3,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.right_chevron,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 0.3,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // You can customize the border style
                            borderRadius: BorderRadius.circular(
                                8), // You can adjust the border radius
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgitPassword()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.lock_shield_fill,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .resetPassword,
                                      style: MyApp.returnLocale(context) ==
                                              Locale("en")
                                          ? TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: subheading3,
                                              color: Colors.white,
                                            )
                                          : TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: subheading3 - 2,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.right_chevron,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
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
