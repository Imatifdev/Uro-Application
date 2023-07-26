// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uroapplication/quiz_screen.dart';
import 'package:uroapplication/search_patients.dart';
import 'package:uroapplication/view/admin/createpatient.dart';
import 'package:uroapplication/view/admin/dashboard.dart';
import 'package:uroapplication/view/admin/login.dart';
import 'package:uroapplication/view/patient/login.dart';
import 'package:uroapplication/view/welcome.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uro App',
        theme: ThemeData(
          fontFamily:
              'MinionVariableConcept-Roman', // Specify the font family here

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Welcome());
  }
}
