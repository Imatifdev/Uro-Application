// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uroapplication/view/admin/createpatient.dart';
import 'package:uroapplication/view/admin/searchpatient.dart';

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
    final subheading = screenWidth * 0.05 * textScaleFactor;

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Image.asset(
                        'assets/images/health.png',
                        height: 50,
                        width: 50,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 100,
              ),
              Container(
                height: screenHeight / 19,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.7),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search Patient ",
                          style:
                              TextStyle(color: subtitle, fontSize: subheading),
                        ),
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    size: 40,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hello, ",
                        style: TextStyle(
                            color: subtitle,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Admin Name",
                        style: TextStyle(color: subtitle, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 60,
              ),
              SizedBox(
                height: screenHeight / 3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      splashColor: Colors.black,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => NewSignupScreen()));
                      },
                      child: Container(
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
                        width: screenWidth / 1.6,
                        height: screenHeight / 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                height: screenHeight / 10,
                                width: screenWidth * 0.2,
                                image: AssetImage('assets/images/newuser.png'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create New ",
                                    style: TextStyle(
                                        color: subtitle,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Patient",
                                        style: TextStyle(
                                            color: subtitle,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                        child: Center(
                                            child: Icon(
                                                CupertinoIcons.right_chevron)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => SearchScreen()));
                      },
                      child: Container(
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
                        width: screenWidth / 1.6,
                        height: screenHeight / 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(
                                  height: screenHeight / 10,
                                  width: screenWidth * 0.2,
                                  image: AssetImage('assets/images/search.png'),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Search Patient",
                                      style: TextStyle(
                                          color: subtitle,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Record",
                                          style: TextStyle(
                                              color: subtitle,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white
                                                  .withOpacity(0.8)),
                                          child: Center(
                                              child: Icon(CupertinoIcons
                                                  .right_chevron)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
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
                      width: screenWidth / 1.6,
                      height: screenHeight / 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                height: screenHeight / 10,
                                width: screenWidth * 0.2,
                                image: AssetImage('assets/images/exp.png'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Export Patient",
                                    style: TextStyle(
                                        color: subtitle,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Data",
                                        style: TextStyle(
                                            color: subtitle,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                        child: Center(
                                            child: Icon(
                                                CupertinoIcons.right_chevron)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
