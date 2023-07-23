// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/widgets/custombutton.dart';

import '../../controller/widgets/customtextfield.dart';
import 'login.dart';

class ForgitPassword extends StatefulWidget {
  static const String idScreen = 'forgotpass';

  const ForgitPassword({super.key});

  @override
  State<ForgitPassword> createState() => _ForgitPasswordState();
}

class _ForgitPasswordState extends State<ForgitPassword> {
  final TextEditingController _email = TextEditingController();
  //key for handling Auth
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent successfully");
    } catch (e) {
      print("Failed to send password reset email: $e");
    }
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                ),
                const Text(
                  "Reset Your Password",
                  style: TextStyle(fontSize: 20),
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
                    textEditingController: _email,
                    hintText: "Enter Your Email",
                    textInputType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 30,
                ),
                MyCustomButton(
                    title: "Save",
                    borderrad: 25,
                    onaction: () {
                      if (formGlobalKey.currentState!.validate()) {
                        resetPassword(_email.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        showSnackbar(context, "Details Send to your email");
                      } else {
                        showSnackbar(context, "Please a valid email address");
                      }
                    },
                    color1: Colors.red,
                    color2: Colors.red,
                    width: MediaQuery.of(context).size.width - 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
