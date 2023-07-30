// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uroapplication/view/admin/createpatient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column hide Row;
import '../../Utils/popup_loader.dart';
import '../../controller/mycolors.dart';
import '../../search_patients.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final String? userName = FirebaseAuth.instance.currentUser!.displayName;

  void openExcel() async {
    PopupLoader.show();
    final QuerySnapshot patientsSnapshot =
        await FirebaseFirestore.instance.collection("Patients").get();
    final QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection("users").get();

    // Create the Excel workbook
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];

    int rowIndex =
        1; // Start from 2nd row as the 1st row will be used for headers

    // Add headers to the Excel sheet
    sheet.getRangeByName('A$rowIndex').setText("Patient ID");
    sheet.getRangeByName('B$rowIndex').setText("First Name");
    sheet.getRangeByName('C$rowIndex').setText("Last Name");
    sheet.getRangeByName('D$rowIndex').setText("Email");
    sheet.getRangeByName('E$rowIndex').setText("DOB");
    sheet.getRangeByName('F$rowIndex').setText("Phone");
    sheet.getRangeByName('G$rowIndex').setText("Quiz 1 Result");
    sheet.getRangeByName('H$rowIndex').setText("Quiz 2 Result");
    rowIndex++;

    // Add the patient data to the Excel sheet
    patientsSnapshot.docs.forEach((patientDocument) {
      final Map<String, dynamic> patientData =
          patientDocument.data() as Map<String, dynamic>;
      final String patientId = patientDocument.id;

      // final userDocument = usersSnapshot.docs
      //     .firstWhere((userDocument) => userDocument.id == patientId);

      // final Map<String, dynamic> userData =
      //     userDocument.data() as Map<String, dynamic>;
      //final List<int?> selectedAnswers = List<int?>.from(userData["selectedAnswers"]);

      sheet.getRangeByName('A$rowIndex').setText(patientId);
      sheet.getRangeByName('B$rowIndex').setText(patientData["First Name"]);
      sheet.getRangeByName('C$rowIndex').setText(patientData["Last Name"]);
      sheet.getRangeByName('D$rowIndex').setText(patientData["Email"]);
      sheet.getRangeByName('E$rowIndex').setText(patientData["DOB"]);
      sheet.getRangeByName('F$rowIndex').setText(patientData["Phone"]);
      //sheet.getRangeByName('G$rowIndex').setText(selectedAnswers.toString());

      rowIndex++;
    });

    // Save the Excel sheet to a file
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/Output.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    PopupLoader.hide();
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading = screenWidth * 0.06 * textScaleFactor;
    final heading = screenWidth * 0.07 * textScaleFactor;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [skyblue, darkblue],
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
                Icons.admin_panel_settings,
                size: 40,
                color: Colors.white,
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
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    userName.toString(),
                    style: TextStyle(color: subtitle, fontSize: 28),
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
                      Image(
                        height: screenHeight / 5,
                        width: screenWidth * 0.3,
                        image: AssetImage('assets/images/newuser.png'),
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
                    MaterialPageRoute(builder: (ctx) => SearchPatient()));
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
                          height: screenHeight / 6,
                          width: screenWidth * 0.25,
                          image: AssetImage('assets/images/searchnew.png'),
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
                          height: screenHeight / 5,
                          width: screenWidth * 0.3,
                          image: AssetImage('assets/images/export.png'),
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
