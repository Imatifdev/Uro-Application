// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphismContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    final fontSize = screenWidth * 0.04 * textScaleFactor;

    // Adjust container size based on screen width and height
    final containerWidth = screenWidth * 0.8;
    final containerHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Select \nYour Role",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: screenHeight / 11,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/patient.png",
                                    ),
                                    height: screenHeight / 6,
                                  ),
                                  Text(
                                    "Patient",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/images/admin.png",
                                    ),
                                    height: screenHeight / 6,
                                  ),
                                  Text("Admin",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
