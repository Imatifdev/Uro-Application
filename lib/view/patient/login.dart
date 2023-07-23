import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive sizes based on the screen size
    //double logoHeight = screenHeight * 0.12;
    double titleFontSize = screenWidth * 0.1;
    double buttonHeight = screenHeight * 0.073;
    double buttonWidth = screenWidth * 0.49;
    double smallTextFontSize = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: screenHeight * 0.16),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/patient.png",
              height: screenHeight * 0.15,
              width: screenWidth * 1,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: screenWidth * 0.1),
          Text(
            "Canary",
            style: TextStyle(
              color: Colors.black,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenWidth * 0.12),
          Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(buttonHeight / 2),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Activate",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SizedBox(height: screenWidth / 10 * 0.1),
          InkWell(
            child: Container(
              height: buttonHeight,
              width: buttonWidth,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(buttonHeight / 2),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Setting",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            onTap: () {},
          ),
          SizedBox(height: screenHeight * 0.14),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.06, bottom: screenWidth * 0.02),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Instructions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: smallTextFontSize,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.06),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "FAQS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: smallTextFontSize,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
