import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uroapplication/view/patient/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    // Start the animation when the splash screen is displayed
    _controller!.forward();

    // Simulate a loading process
    Future.delayed(const Duration(seconds: 2), () {
      //Navigate to the main screen after loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreenPatient()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0047ba),
      body: Center(
        child: Image(
            height: 300,
            width: 300,
            image: AssetImage('assets/images/logo.png')),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
