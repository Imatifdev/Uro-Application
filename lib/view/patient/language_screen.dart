import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'en';
  void changeLocale(value) {
    MyApp.setLocale(context, Locale(value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff0047ba),
      appBar: AppBar(
        backgroundColor: Color(0xff0047ba),
        toolbarHeight: height * 0.09,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 80,
          color: Colors.white,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.left_chevron),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.09,
            ),
            const Text(
              "Change Language",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            RadioListTile<String>(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.yellow),
              activeColor: Colors.yellow,
              title: const Text(
                'English',
                style: TextStyle(color: Colors.white),
              ),
              value: 'en',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  changeLocale(value);
                  selectedLanguage = value!;
                });
              },
            ),
            RadioListTile<String>(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.yellow),
              activeColor: Colors.yellow,
              title: const Text(
                'Urdu',
                style: TextStyle(color: Colors.white),
              ),
              value: 'ur',
              groupValue: selectedLanguage,
              onChanged: (value) {
                changeLocale(value);
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
          ],
        ),
      )),
    );
  }
}
