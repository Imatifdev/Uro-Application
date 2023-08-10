import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:uroapplication/view/patient/oab.dart';
import 'package:uroapplication/view/patient/patientdashboard.dart';
import 'package:uroapplication/view/patient/profile.dart';

import '../../controller/mycolors.dart';
import '../../main.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome>
    with SingleTickerProviderStateMixin {
       String selectedLanguage = 'en';
       void changeLocale(value) {
    MyApp.setLocale(context, Locale(value));
  }

      @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
     showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose a Language'),
            content:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
            actions: [
              TextButton(
                onPressed: () {
                  changeLocale("en");
                  Navigator.pop(context);
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.red),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Confirm', style: TextStyle(color: Colors.green),),
              ),
            ],
          );});
          
    });
    super.initState();
  }


  int _currentIndex = 0;
  final List<Widget> _screens = [
    PatientDashboard(),
    OABScreen(),
    ProfileView(),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: blue.withOpacity(0.1),
          buttonBackgroundColor: pink,
          backgroundColor: blue,
          height: 50,
          animationDuration: const Duration(milliseconds: 200),
          index: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.add_box_outlined, size: 30, color: Colors.white),
            Icon(Icons.person_pin, size: 30, color: Colors.white),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (ctx) => const RequestLeave()),
        //     );
        //   },
        //   child: const Icon(Icons.add),
        // ),
        body: _screens[_currentIndex]);
  }
}
