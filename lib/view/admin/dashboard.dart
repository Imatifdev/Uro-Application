// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../controller/mycolors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    final fontSize = screenWidth * 0.14 * textScaleFactor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3626af), Color.fromARGB(255, 133, 92, 231)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 60,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Uro",
                        style: TextStyle(
                            fontSize: fontSize,
                            color: title,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Care",
                        style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: screenHeight / 2,
                width: screenWidth,
                child: Row(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
