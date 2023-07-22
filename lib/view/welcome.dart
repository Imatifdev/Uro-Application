// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

import 'admin/dashboard.dart';

class GlassmorphismContainer extends StatefulWidget {
  @override
  State<GlassmorphismContainer> createState() => _GlassmorphismContainerState();
}

class _GlassmorphismContainerState extends State<GlassmorphismContainer> {
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
    bool _isExpanded = false;

    void _toggleExpand() {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3626af), Color.fromARGB(255, 133, 92, 231)],
          ),
        ),
        child: Column(
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
                      color: Colors.white.withOpacity(0.2),
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
                              "Select ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Your Role",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: screenHeight / 16,
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => Dashboard()));
                                  },
                                  child: Column(
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
                                  ),
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
      ),
    );
  }
}
