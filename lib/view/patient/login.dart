// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_element, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:uroapplication/controller/mycolors.dart';
import 'package:uroapplication/view/patient/patientdashboard.dart';

import '../../models/loginmodel.dart';
import 'package:velocity_x/velocity_x.dart';

import 'createpatient.dart';
import 'forgot.dart';

class LoginScreenPatient extends StatefulWidget {
  const LoginScreenPatient({super.key});

  @override
  State<LoginScreenPatient> createState() => _LoginScreenPatientState();
}

class _LoginScreenPatientState extends State<LoginScreenPatient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool obsCheck = false;

  bool _isLoggingIn = false;
  bool _isPasswordVisible = false;

  final LoginViewModel _loginVM = LoginViewModel();

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return "null";
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return "null";
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
    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Perform login or further actions
        String email = _emailController.text;
        String password = _passwordController.text;
        // Process the login credentials
        print('Email: $email');
        print('Password: $password');
      }
    }

    var height = MediaQuery.of(context).size.height;

    //var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffe1e6ef),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                        child: Lottie.asset('assets/log.json',
                            height: height / 3.5)),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hello Again!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: blue),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {}
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {}
                          return null;
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            fillColor: Colors.white,
                            hintText: "Email Address",
                            suffixIcon: Icon(CupertinoIcons.mail),
                            hintStyle: TextStyle(color: Colors.black),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true),
                      ),
                    ),
                    SizedBox(
                      height: height / 62,
                    ),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {}
                          if (value.length < 6) {}
                          return null;
                        },
                        obscureText: _isPasswordVisible,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            errorStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            fillColor: Colors.white,
                            hintText: "Password ",
                            hintStyle: TextStyle(color: Colors.black),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ForgitPassword()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )
                  ],
                ).pSymmetric(h: 20),
                SizedBox(
                  height: height / 20,
                ),
                InkWell(
                  splashColor: Colors.white,
                  onTap: _isLoggingIn
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            if (_emailController.text.isEmpty &&
                                _passwordController.text.isEmpty) {
                              showSnackbar(context, "Please fill all fields");
                              return;
                            }
                            setState(() {
                              _isLoggingIn = true;
                            });
                            bool isLoggedIn = await _loginVM.login(
                                _emailController.text,
                                _passwordController.text);
                            if (isLoggedIn) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PatientDashboard(),
                              ));
                            }
                            setState(() {
                              _isLoggingIn = false;
                            });
                            if (!isLoggedIn) {
                              showSnackbar(
                                  context, "Invalid email or Password");
                            } else {}
                          }
                        },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: pink,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _isLoggingIn
                          ? Lottie.asset(
                              'assets/login.json', // Replace with your animation file path
                              height: 30,
                              width: 30,
                            ).centered()
                          : const Text(
                              'Log In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ).centered(),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an Account? ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Signup',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewSignupScreen()));
                          },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
