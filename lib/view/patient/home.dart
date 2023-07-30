import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:uroapplication/view/patient/oab.dart';
import 'package:uroapplication/view/patient/patientdashboard.dart';
import 'package:uroapplication/view/patient/profile.dart';
import 'package:uroapplication/view/patient/settings.dart';

import '../../controller/mycolors.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeState(),
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
