// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uroapplication/Utils/popup_loader.dart';
import 'package:uroapplication/controller/mycolors.dart';
import 'package:uroapplication/view/calculator/result_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> questions = [
      AppLocalizations.of(context)!.ipssQuestion1,
      AppLocalizations.of(context)!.ipssQuestion2,
      AppLocalizations.of(context)!.ipssQuestion3,
      AppLocalizations.of(context)!.ipssQuestion4,
      AppLocalizations.of(context)!.ipssQuestion5
    ];
    List<String> headings = [
      AppLocalizations.of(context)!.ipssHeading1,
      AppLocalizations.of(context)!.ipssHeading2,
      AppLocalizations.of(context)!.ipssHeading3,
      AppLocalizations.of(context)!.ipssHeading4,
      AppLocalizations.of(context)!.ipssHeading5
    ];
    List<List<String>> answers = [
      [
        AppLocalizations.of(context)!.ipssOneAnswer1,
        AppLocalizations.of(context)!.ipssOneAnswer2,
        AppLocalizations.of(context)!.ipssOneAnswer3,
        AppLocalizations.of(context)!.ipssOneAnswer4,
        AppLocalizations.of(context)!.ipssOneAnswer5,
        AppLocalizations.of(context)!.ipssOneAnswer6,
      ],
      [
        AppLocalizations.of(context)!.ipssOneAnswer1,
        AppLocalizations.of(context)!.ipssOneAnswer2,
        AppLocalizations.of(context)!.ipssOneAnswer3,
        AppLocalizations.of(context)!.ipssOneAnswer4,
        AppLocalizations.of(context)!.ipssOneAnswer5,
        AppLocalizations.of(context)!.ipssOneAnswer6,
      ],
      [
        AppLocalizations.of(context)!.ipssTwoAnswer1,
        AppLocalizations.of(context)!.ipssTwoAnswer2,
        AppLocalizations.of(context)!.ipssTwoAnswer3,
        AppLocalizations.of(context)!.ipssTwoAnswer4,
        AppLocalizations.of(context)!.ipssTwoAnswer5,
        AppLocalizations.of(context)!.ipssTwoAnswer6,
      ],
      [
        AppLocalizations.of(context)!.ipssThreeAnswer1,
        AppLocalizations.of(context)!.ipssThreeAnswer2,
        AppLocalizations.of(context)!.ipssThreeAnswer3,
        AppLocalizations.of(context)!.ipssThreeAnswer4,
        AppLocalizations.of(context)!.ipssThreeAnswer5,
        AppLocalizations.of(context)!.ipssThreeAnswer6,
      ],
      [
        AppLocalizations.of(context)!.ipssFourAnswer1,
        AppLocalizations.of(context)!.ipssFourAnswer2,
        AppLocalizations.of(context)!.ipssFourAnswer3,
        AppLocalizations.of(context)!.ipssFourAnswer4,
        AppLocalizations.of(context)!.ipssFourAnswer5,
        AppLocalizations.of(context)!.ipssFourAnswer6,
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
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [grad1, grad2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "IPSS Quiz",
                          style: TextStyle(
                              fontSize: heading,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset('assets/images/logo.png',height: 60,)
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < 5; i++)
                          buildCircleAvatar(constraints, i),
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: questions.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) => Card(
                          color: Colors.white30,
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
                                                    ? pink
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
                                                        : pink),
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
            ),
          );
        },
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
        'sum': sum,
        "time": DateTime.now()
      };

      await usersCollection.doc("Quiz 2").set(userData);
      await FirebaseFirestore.instance
          .collection("QuizHistory")
          .doc(user.uid)
          .collection("Quiz2History")
          .add(userData);
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
        radius: constraints.maxWidth * 0.05,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: constraints.maxWidth * 0.045,
          backgroundColor: answered[index] ? skyblue : pink,
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
      backgroundColor: pink,
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
        icon: Icon(Icons.arrow_back_ios_new,
            color: Colors.white, size: constraints.maxWidth * 0.05),
      ),
    );
  }

  CircleAvatar buildForwardButton(BoxConstraints constraints) {
    return CircleAvatar(
      radius: constraints.maxWidth * 0.05,
      backgroundColor: pink,
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
            color: Colors.white, size: constraints.maxWidth * 0.05),
      ),
    );
  }
}
