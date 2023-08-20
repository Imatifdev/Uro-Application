import 'package:flutter/material.dart';
import 'package:uroapplication/view/calculator/quiz_screen.dart';

import '../calculator/quiz2_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OAB(),
                    ));
                  },
                  child: const Text("Quiz 1")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IPSS(),
                    ));
                  },
                  child: const Text("Quiz 2"))
            ],
          ),
        ),
      ),
    );
  }
}
