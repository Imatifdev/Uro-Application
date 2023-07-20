import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controller/widgets/custombutton.dart';
import '../../controller/widgets/customtextfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //final TextEditingController _passController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  Future<void> updateUserData(String uid, String newUsername, String newEmail,
      String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'First Name': newUsername,
        'Email': newEmail,
      });
      print('Document updated successfully.');
    } catch (e) {
      print('Error updating document: $e');
    }
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(uid)
        .set({'Patient Record': newUsername}, SetOptions(merge: true));
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.grey[800],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (value.length < 2) {
                          return 'Enter a valid name';
                        }
                        return null;
                      },
                      textEditingController: _nameController,
                      hintText: "Abc",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textEditingController: _emailController,
                      hintText: "abc@gmail.com",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (value.length < 11) {
                          return 'Enter a valid phone num';
                        }
                        return null;
                      },
                      textEditingController: _mobilecontroller,
                      hintText: "2567388929",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyCustomButton(
                              title: "Cancel",
                              borderrad: 25,
                              onaction: () {
                                Navigator.pop(context);
                              },
                              color1: Colors.red,
                              color2: Colors.red,
                              width: MediaQuery.of(context).size.width),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: MyCustomButton(
                              title: "Save",
                              borderrad: 25,
                              onaction: () {
                                updateUserData(
                                    userId,
                                    _nameController.text,
                                    _emailController.text,
                                    _mobilecontroller.text);
                                showSnackbar(context,
                                    "Your account has has been updated");
                              },
                              color1: Colors.green,
                              color2: Colors.green,
                              width: MediaQuery.of(context).size.width),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
