import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text("Change Language", style: TextStyle(fontSize: 22),),
              RadioListTile<String>(
                  title: const Text('English'),
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
                  title: const Text('Urdu'),
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
         ) 
        ),
    );
  }
}