// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/view/calculator/result_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../Utils/popup_loader.dart';

class OAB extends StatefulWidget {
  const OAB({super.key});

  @override
  State<OAB> createState() => _OABState();
}

class _OABState extends State<OAB> {
  final PageController _pageController = PageController();
  List<int?> selectedAnswers = List.filled(7, null);
  List<bool> answered = List.filled(7, false);
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

  

  @override
  Widget build(BuildContext context) {

    List<String> questions = [
    AppLocalizations.of(context)!.oabQuestion1,
    AppLocalizations.of(context)!.oabQuestion2,
    AppLocalizations.of(context)!.oabQuestion3,
    AppLocalizations.of(context)!.oabQuestion4,
    AppLocalizations.of(context)!.oabQuestion5,
    AppLocalizations.of(context)!.oabQuestion6,
    AppLocalizations.of(context)!.oabQuestion7,
    ];
  List<String> headings = [
    AppLocalizations.of(context)!.oabHeading1,
    AppLocalizations.of(context)!.oabHeading2,
    AppLocalizations.of(context)!.oabHeading3,
    AppLocalizations.of(context)!.oabHeading4,
    AppLocalizations.of(context)!.oabHeading5,
    AppLocalizations.of(context)!.oabHeading6,
    AppLocalizations.of(context)!.oabHeading7,
  ];
  List<List<String>> answers = [
    [
      AppLocalizations.of(context)!.oabAnswer1,
      AppLocalizations.of(context)!.oabAnswer2,
      AppLocalizations.of(context)!.oabAnswer3,
      AppLocalizations.of(context)!.oabAnswer4,
      AppLocalizations.of(context)!.oabAnswer5,
      AppLocalizations.of(context)!.oabAnswer6,
    ],
    [
      AppLocalizations.of(context)!.oabAnswer1,
      AppLocalizations.of(context)!.oabAnswer2,
      AppLocalizations.of(context)!.oabAnswer3,
      AppLocalizations.of(context)!.oabAnswer4,
      AppLocalizations.of(context)!.oabAnswer5,
      AppLocalizations.of(context)!.oabAnswer6,
    ],
    [
      AppLocalizations.of(context)!.oabAnswer1,
      AppLocalizations.of(context)!.oabAnswer2,
      AppLocalizations.of(context)!.oabAnswer3,
      AppLocalizations.of(context)!.oabAnswer4,
      AppLocalizations.of(context)!.oabAnswer5,
      AppLocalizations.of(context)!.oabAnswer6,
    ],
    [
      AppLocalizations.of(context)!.oabAnswer1,
      AppLocalizations.of(context)!.oabAnswer2,
      AppLocalizations.of(context)!.oabAnswer3,
      AppLocalizations.of(context)!.oabAnswer4,
      AppLocalizations.of(context)!.oabAnswer5,
      AppLocalizations.of(context)!.oabAnswer6,
    ],
    [
      AppLocalizations.of(context)!.oabAnswer1,
      AppLocalizations.of(context)!.oabAnswer2,
      AppLocalizations.of(context)!.oabAnswer3,
      AppLocalizations.of(context)!.oabAnswer4,
      AppLocalizations.of(context)!.oabAnswer5,
      AppLocalizations.of(context)!.oabAnswer6,
    ],
    [
      AppLocalizations.of(context)!.oabAnswer1,
      AppLocalizations.of(context)!.oabAnswer2,
      AppLocalizations.of(context)!.oabAnswer3,
      AppLocalizations.of(context)!.oabAnswer4,
      AppLocalizations.of(context)!.oabAnswer5,
      AppLocalizations.of(context)!.oabAnswer6,
    ],
    [
      AppLocalizations.of(context)!.oabLastAnswer1,
      AppLocalizations.of(context)!.oabLastAnswer2,
      AppLocalizations.of(context)!.oabLastAnswer3,
      AppLocalizations.of(context)!.oabLastAnswer4,
      AppLocalizations.of(context)!.oabLastAnswer5,
      AppLocalizations.of(context)!.oabLastAnswer6,
    ],
  ];

    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading = screenWidth * 0.06 * textScaleFactor;
    final heading = screenWidth * 0.09 * textScaleFactor;
    //final fontsize = screenWidth * 0.07 * textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.blue,
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
                    const Text("OAB Quiz"),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < 7; i++)
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
                          color: Colors.pink.shade100 ,
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
                                            "${AppLocalizations.of(context)!.questionNo} ${index + 1}/7",
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
                                                    ? Colors.pink
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
                                                        : Colors.pink),
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

      //  if (user != null) {
      final userData = {'selectedAnswers': selectedAnswers, 'sum': sum, "time":DateTime.now()};

      await usersCollection.doc("Quiz 1").set(userData);
      await FirebaseFirestore.instance.collection("QuizHistory").doc(user.uid).collection("Quiz1History").add(userData);
      print("User answers saved to Firestore successfully!");
      PopupLoader.hide();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ResultScreen(answers: selectedAnswers, avg: sum, qNum: 7),
      ));
      // }
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
            return Colors.pink.shade100;
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
              answered[index] ? Colors.pink.shade100 : Colors.pink,
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
