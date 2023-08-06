import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uroapplication/view/calculator/quiz2_screen.dart';

class ResultScreen extends StatefulWidget {
  final List answers;
  final num avg;
  final int qNum;
  const ResultScreen({
    Key? key,
    required this.answers,
    required this.avg,
    required this.qNum,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final subheading = screenWidth * 0.06 * textScaleFactor;
    final heading = screenWidth * 0.07 * textScaleFactor;

    Size size = MediaQuery.of(context).size;
    int questionScore = widget.qNum == 7 ? 35 : 25;

    LinearGradient getProgressBarGradient(double percentage) {
      if (percentage <= 0.4) {
        return LinearGradient(colors: [Colors.green.shade900, Colors.green]);
      } else if (percentage < 0.7) {
        return LinearGradient(colors: [Colors.orange, Colors.yellow.shade300]);
      } else {
        return LinearGradient(colors: [Colors.orange.shade700, Colors.red]);
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SizedBox(
          height: size.height - 100,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset('assets/res.json'),
                LinearPercentIndicator(
                  lineHeight: 40,
                  barRadius: const Radius.circular(15),
                  percent: (widget.avg / questionScore),
                  center: Text(
                    "${((widget.avg / questionScore) * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(color: Colors.black),
                  ),
                  animation: true,
                  animationDuration: 1800,
                  curve: Curves.bounceOut,
                  linearGradient:
                      getProgressBarGradient(widget.avg / questionScore),
                ),
                Text(
                  "According to Our Calculator there is ${((widget.avg / questionScore) * 100).toStringAsFixed(1)}% chance that you have a problem",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(
                //   height: 60 * 7,
                //   child: ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: widget.answers.length,
                //     itemBuilder: (context, index) => Column(
                //       children: [
                //         ListTile(
                //           title: Text(
                //             "Question ${index + 1}",
                //             style: const TextStyle(color: Colors.white),
                //           ),
                //           trailing: Text(
                //             widget.answers[index].toString(),
                //             style: const TextStyle(
                //                 color: Colors.white, fontSize: 18),
                //           ),
                //         ),
                //         Divider()
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: size.width - 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.pink,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Your Score: ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: subheading),
                            ),
                          ),
                          Text(
                            "${widget.avg.toString()}/$questionScore",
                            style: TextStyle(
                                color: Colors.white, fontSize: subheading),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(seconds: 2),
                        type: PageTransitionType.fade,
                        child: IPSS(),
                      ),
                    );
                  },
                  icon: Icon(Icons.restart_alt),
                  label: Text("Restart"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
