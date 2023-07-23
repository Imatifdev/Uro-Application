// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_element, no_leading_underscores_for_local_identifiers, avoid_print, sort_child_properties_last, use_build_context_synchronously, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../models/registermodel.dart';
import 'login.dart';
import 'package:velocity_x/velocity_x.dart';

class NewSignupScreen extends StatefulWidget {
  @override
  State<NewSignupScreen> createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _fname = TextEditingController();

  final TextEditingController _lname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final RegisterViewModel _registerVM = RegisterViewModel();
  DateTime? _selectedDate;
  bool _isDataSaved = false;

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dob.text = _selectedDate!.toLocal().toString().split(' ')[0];
      });
    }
  }

  String errMsg = "";
  bool _isSigningUp = false;
  bool _isPasswordVisible = false;

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

  String _validatename(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length < 3) {
      return 'Name should be valid';
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
        // String email = _emailController.text;
        // String password = _passwordController.text;

        // Process the login credentials
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
            child: SizedBox(
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 13,
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 10,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {}
                              if (value.length < 3) {}
                              return null;
                            },
                            controller: _lname,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                fillColor: Colors.white,
                                hintText: "Last Name",
                                hintStyle: TextStyle(color: Colors.black),
                                alignLabelWithHint: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: height / 64,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 10,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {}
                              if (value.length < 3) {}
                              return null;
                            },
                            controller: _fname,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                fillColor: Colors.white,
                                hintText: "Full Name",
                                hintStyle: TextStyle(color: Colors.black),
                                alignLabelWithHint: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: height / 64,
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                          height: height / 64,
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                                        ? Icons.visibility
                                        : Icons.visibility_off,
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
                          height: height / 64,
                        ),
                        InkWell(
                          onTap: () {
                            _pickDate;
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              readOnly: true,
                              controller: _dob,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.black),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  fillColor: Colors.white,
                                  hintText: "Date of Borth",
                                  suffixIcon: IconButton(
                                      onPressed: _pickDate,
                                      icon: Icon(CupertinoIcons.calendar)),
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
                        ),
                        SizedBox(
                          height: height / 64,
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            readOnly: true,
                            controller: _phone,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                fillColor: Colors.white,
                                hintText: "Phone Num",
                                suffixIcon: IconButton(
                                    onPressed: _pickDate,
                                    icon: Icon(CupertinoIcons.calendar)),
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
                      ],
                    ).pSymmetric(h: 20),
                    SizedBox(
                      height: height / 10,
                    ),

                    InkWell(
                      onTap: _isDataSaved
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                if (_emailController.text.isEmpty &&
                                    _passwordController.text.isEmpty) {
                                  showSnackbar(
                                      context, "Please fill all fields");
                                  return;
                                }
                                setState(() {
                                  _isSigningUp = true;
                                });

                                // call Firebase function to sign up user
                                bool isRegistered = false;
                                isRegistered = await _registerVM.register(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                    _fname.text.trim(),
                                    _lname.text.trim(),
                                    _dob.text.trim(),
                                    _phone.text.trim());

                                if (isRegistered) {
                                  var userId =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  await FirebaseFirestore.instance
                                      .collection("Patients")
                                      .doc(userId)
                                      .set({
                                    "First Name": _fname.text.trim(),
                                    "Last Name": _lname.text.trim(),
                                    "Email": _emailController.text.trim(),
                                    "DOB": _dob.text.trim(),
                                    "Phone": _phone.text.trim()
                                  });

                                  // Update the state to indicate data is saved
                                  setState(() {
                                    _isDataSaved = true;
                                    _isSigningUp = false;
                                  });

                                  // Show a Snackbar to indicate data is saved
                                  showSnackbar(context, "Data Saved!");
                                } else {
                                  setState(() {
                                    _isSigningUp = false;
                                    errMsg = _registerVM.message;
                                  });
                                }
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
                            color: Color(0xff2ddcdc),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: _isSigningUp
                              ? const CircularProgressIndicator().centered()
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ).centered(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 42,
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'By signing up you are accepting ',
                    //     style: TextStyle(color: Colors.black, fontSize: 16),
                    //     children: const <TextSpan>[
                    //       TextSpan(
                    //         text: 'Terms and',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Conditions ',
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16),
                    //     children: const <TextSpan>[
                    //       TextSpan(
                    //         text: 'and',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: ' Privacy Policy',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: height / 35,
                    // ),
                    RichText(
                      text: TextSpan(
                        text: 'Already have an Account? ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Log in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2ddcdc),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onaction;
  const MyButton({
    super.key,
    required this.title,
    required this.onaction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onaction,
      child: Container(
        height: 40,
        width: 300,
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: Colors.white),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontsize;
  final FontWeight? fontWeight;
  final Color? color;
  const CustomText(
      {super.key,
      required this.fontsize,
      this.fontWeight,
      required this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color),
    );
  }
}
