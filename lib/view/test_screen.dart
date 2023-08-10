import 'package:flutter/material.dart';
import 'package:uroapplication/view/calculator/quiz2_screen.dart';
import 'package:uroapplication/view/calculator/quiz_screen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OAB(),));
          }, child: const Text("OAB")),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const IPSS(),));
          }, child: const Text("IPSS"))
        ],
      ),
    );
  }
}