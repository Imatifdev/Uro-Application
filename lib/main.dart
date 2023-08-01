// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uroapplication/view/patient/home.dart';
import 'package:uroapplication/view/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';

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
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Uro App',
      theme: ThemeData(
        fontFamily:
            'MinionVariableConcept-Roman', // Specify the font family here

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: //PatientHome(),
      FirebaseAuth.instance.currentUser == null ? Welcome() : PatientHome(),
      supportedLocales: L10n.all,
      locale: const Locale("en"),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
