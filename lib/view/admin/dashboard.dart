// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uroapplication/view/admin/createpatient.dart';
import 'package:uroapplication/view/admin/searchpatient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column hide Row;
import '../../controller/mycolors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  openExcel()async{
    
    final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection("Patients").doc(userId).get();
    // Create the Excel workbook
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];

  // Add the patient data to the Excel sheet
  final Map<String, dynamic> patientData = snapshot.data() as Map<String, dynamic>;
  int rowIndex = 1; // Start from 2nd row as the 1st row will be used for headers
  patientData.forEach((key, value) {
    sheet.getRangeByName('A$rowIndex').setText(key);
    sheet.getRangeByName('B$rowIndex').setText(value.toString());
    rowIndex++;
  });

  // Save the Excel sheet to a file
  final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/Output.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(file.path); 

  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading = screenWidth * 0.07 * textScaleFactor;
    final heading = screenWidth * 0.09 * textScaleFactor;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [blue, darkblue],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: screenHeight / 60,
          ),
          SizedBox(
            height: screenHeight / 100,
          ),
          SizedBox(
            height: screenHeight / 5,
            width: 300,
            child: Image.asset('assets/images/logo.png'),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
          Column(children: [
            InkWell(
              splashColor: Colors.black,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => NewSignupScreen()));
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
                width: screenWidth * 1 - 30,
                height: screenHeight / 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create New ",
                              style: TextStyle(
                                  color: subtitle,
                                  fontSize: subheading,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Patient",
                                  style: TextStyle(
                                      color: subtitle,
                                      fontSize: heading,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Image(
                          height: screenHeight / 10,
                          width: screenWidth * 0.2,
                          image: AssetImage('assets/images/newuser.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 0.5,
              ),
            ),
            InkWell(
              splashColor: Colors.black,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => SearchScreen()));
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
                width: screenWidth * 1 - 30,
                height: screenHeight / 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Search a Patient  ",
                              style: TextStyle(
                                  color: subtitle,
                                  fontSize: subheading,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Record",
                                  style: TextStyle(
                                      color: subtitle,
                                      fontSize: heading,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Image(
                          height: screenHeight / 10,
                          width: screenWidth * 0.2,
                          image: AssetImage('assets/images/search.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 0.5,
              ),
            ),
            InkWell(
              splashColor: Colors.black,
              onTap: () {
                openExcel();
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
                width: screenWidth * 1 - 30,
                height: screenHeight / 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Export Data",
                              style: TextStyle(
                                  color: subtitle,
                                  fontSize: subheading,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Patient",
                                  style: TextStyle(
                                      color: subtitle,
                                      fontSize: heading,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Image(
                          height: screenHeight / 10,
                          width: screenWidth * 0.2,
                          image: AssetImage('assets/images/exp.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ]),
      ),
    ));
  }
}
