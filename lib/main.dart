// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:uroapplication/view/patient/patientdashboard.dart';
import 'package:uroapplication/view/splash.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  static Locale returnLocale(BuildContext context) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    Locale locale = state!.returnLocle();
    return locale;
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("en");
  setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  returnLocle() {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Uro App',
      theme: ThemeData(
        //brightness: Brightness.dark,
        fontFamily: 'MinionVariableConcept-Roman',

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: //PatientHome(),
          FirebaseAuth.instance.currentUser == null
              ? SplashScreen()
              : PatientDashboard(),
      supportedLocales: L10n.all,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
