// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/Utils/popup_loader.dart';
import 'package:uroapplication/view/calculator/result_screen.dart';

class IPSS extends StatefulWidget {
  const IPSS({super.key});

  @override
  State<IPSS> createState() => _IPSSState();
}

class _IPSSState extends State<IPSS> {
  final PageController _pageController = PageController();
  List<int?> selectedAnswers = List.filled(5, null);
  List<bool> answered = List.filled(5, false);
  int currentPage = 0;
  int sum = 0;

  SizedBox buildHeadingText(String text, double fontSize, bool bold) {
    return SizedBox(
      width: 500,
      child: Text(
        text,
        softWrap: true,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  List<String> questions = [
    "How often do you have a strong, sudden urge to urinate that makes you fear you will leak urine if you can't get to a bathroom immediately?",
    "How often do you leak urine after feeling a strong urge to go? (whether you wear pads/protection or not)",
    "How much urine do you think usually leaks? (whether you wear pads/protection or not)",
    "How often do you urinate during the day?",
    "How many times do you usually get up at night to urinate, from when you went to bed until you get up in the morning?",
  ];
  List<String> headings = [
    "Urgency",
    "Urgency Incontinence",
    "Incontinence",
    "Frequency",
    "Waking to Urinate"
  ];
  List<List<String>> answers = [
    [
      "Not at all",
      "Occasionally",
      "About once a day",
      "About three times a day",
      "About half the time",
      "Almost always"
    ],
    [
      "Not at all",
      "Occasionally",
      "About once a day",
      "About three times a day",
      "About half the time",
      "Almost always"
    ],
    [
      "None",
      "Drops",
      "1 tea spoon",
      "1 table spoon",
      "1/4 cup",
      "Entire Bladder",
    ],
    [
      "1-6 times",
      "7-8 times",
      "9-10 times",
      "11-12 times",
      "13-14 times",
      "15 or more times"
    ],
    ["None", "1 time", "2 times", "3 times", "4 times", "5 or more times"],
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading = screenWidth * 0.06 * textScaleFactor;
    final heading = screenWidth * 0.09 * textScaleFactor;
    //final fontsize = screenWidth * 0.07 * textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < 5; i++)
                          buildCircleAvatar(constraints, i),
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.7,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: questions.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) => Card(
                          color: Colors.deepPurple.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: buildHeadingText(
                                      headings[index], heading, false),
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: buildHeadingText(
                                            "Question No ${index + 1}/5",
                                            subheading,
                                            true),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: buildHeadingText(
                                          questions[index], subheading, false),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0;
                                        i < answers[index].length;
                                        i++)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedAnswers[currentPage] = i;
                                            answered[currentPage] = true;
                                          });
                                        },
                                        child: Container(
                                          width: constraints.maxWidth * 0.8,
                                          height: constraints.maxHeight * 0.06,
                                          decoration: BoxDecoration(
                                            color:
                                                selectedAnswers[currentPage] ==
                                                        i
                                                    ? Colors.deepPurple
                                                    : Colors.white,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                answers[index][i],
                                                style: TextStyle(
                                                    color: selectedAnswers[
                                                                currentPage] ==
                                                            i
                                                        ? Colors.white
                                                        : Colors.deepPurple),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildBackButton(constraints),
                        buildSubmitButton(constraints),
                        buildForwardButton(constraints),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> saveUserAnswersToFirestore() async {
    PopupLoader.show();
    final user = FirebaseAuth.instance.currentUser;
    for (int i = 0; i < selectedAnswers.length; i++) {
      sum += selectedAnswers[i] as int;
    }
    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('QuizResults')
          .doc(user!.uid)
          .collection("Result");

      // if (user != null) {
      final userData = {
        'selectedAnswers': selectedAnswers,
      };

      await usersCollection.doc("Quiz 2").set(userData);
      print("User answers saved to Firestore successfully!");
      PopupLoader.hide();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ResultScreen(answers: selectedAnswers, avg: sum, qNum: 5),
      ));
      //  }
    } catch (e) {
      PopupLoader.hide();
      print("Error saving user answers to Firestore: $e");
    }
  }

  bool isAllQuestionsAnswered() {
    for (int? answer in selectedAnswers) {
      if (answer == null) {
        return false;
      }
    }
    return true;
  }

  ElevatedButton buildSubmitButton(BoxConstraints constraints) {
    return ElevatedButton(
      onPressed: isAllQuestionsAnswered()
          ? () async {
              sum = 0;
              print("Selected Answers: $selectedAnswers");
              await saveUserAnswersToFirestore();
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return Colors.deepPurple.shade100;
          },
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text("Submit"),
      ),
    );
  }

  InkWell buildCircleAvatar(BoxConstraints constraints, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentPage = index;
          _pageController.animateToPage(
            currentPage,
            duration: const Duration(seconds: 2),
            curve: Curves.decelerate,
          );
        });
      },
      child: CircleAvatar(
        radius: constraints.maxWidth * 0.06,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: constraints.maxWidth * 0.05,
          backgroundColor:
              answered[index] ? Colors.deepPurple.shade100 : Colors.deepPurple,
          child: answered[index]
              ? const Icon(Icons.check, color: Colors.white)
              : Text((index + 1).toString(),
                  style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  CircleAvatar buildBackButton(BoxConstraints constraints) {
    return CircleAvatar(
      radius: constraints.maxWidth * 0.05,
      child: IconButton(
        onPressed: () {
          if (currentPage > 0) {
            setState(() {
              currentPage--;
            });
            _pageController.previousPage(
                duration: const Duration(seconds: 2), curve: Curves.decelerate);
          }
        },
        icon: Icon(Icons.arrow_back_ios_new, size: constraints.maxWidth * 0.05),
      ),
    );
  }

  CircleAvatar buildForwardButton(BoxConstraints constraints) {
    return CircleAvatar(
      radius: constraints.maxWidth * 0.05,
      child: IconButton(
        onPressed: () {
          if (currentPage < 6) {
            setState(() {
              currentPage++;
            });
            _pageController.nextPage(
                duration: const Duration(seconds: 2), curve: Curves.decelerate);
          }
        },
        icon: Icon(Icons.arrow_forward_ios_sharp,
            size: constraints.maxWidth * 0.05),
      ),
    );
  }
}
