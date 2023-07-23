// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();
  List<int?> selectedAnswers = List.filled(7, null);
  List<bool> answered = List.filled(7, false);
  int currentPage = 0; // Changed to start from 0
  List<String> questions = [
    "Over the past month, how often have you had the sensation of not emptying your bladder completely after you finish urinating?",
    "Over the past month, how often have you had to urinate again less than two hours after you finished urinating?",
    "Over the past month, how often have you found you stopped and started again several times when you urinated?",
    "Over the past month, how difficult you found it to postpone urination?",
    "Over the past month, how often have you had a weak urinary stream?",
    "Over the past month, how often have you had to push or strain to begin urination?",
    "Over the past month, how many times did you most typically get up to urinate from the time you went to bed until the time you got up in the morning?"
  ];
  List<String> headings = [
    "Incomplete Emptying",
    "Frequency",
    "Intermittency",
    "Urgency",
    "Weak Stream",
    "Straining",
    "Nocturia"
  ];

  List<List<String>> answers = [
    ["Not at all", "Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all", "Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all", "Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all", "Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all", "Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all", "Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["None", "1 Time", "2 Times", "3 Times", "4 Times", "5 Times or more"]
  ];

  @override
  Widget build(BuildContext context) {
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
                        for (int i = 0; i < 7; i++)
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
                          color: Colors.deepPurple.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(headings[index], style: const TextStyle(fontSize: 20)),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Question No ${index + 1}/7", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    ),
                                    Text(questions[index], style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < answers[index].length; i++)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedAnswers[currentPage] = i; // Updated to currentPage instead of currentPage - 1
                                            answered[currentPage] = true; // Updated to currentPage instead of currentPage - 1
                                          });
                                        },
                                        child: Container(
                                          width: constraints.maxWidth * 0.8,
                                          height: constraints.maxHeight * 0.06,
                                          decoration: BoxDecoration(
                                            color: selectedAnswers[currentPage] == i ? Colors.deepPurple : Colors.white,
                                            border: Border.all(color: Theme.of(context).primaryColor),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              answers[index][i],
                                              style: TextStyle(color: selectedAnswers[currentPage] == i ? Colors.white : Colors.deepPurple),
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
    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userData = {
          'userId': user.uid,
          'selectedAnswers': selectedAnswers,
        };

        await usersCollection.doc(user.uid).set(userData);
        print("User answers saved to Firestore successfully!");
      }
    } catch (e) {
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
          ? () async{
            print("Selected Answers: $selectedAnswers");
            await saveUserAnswersToFirestore();
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Disabled color
            }
            return Colors.deepPurple.shade100; // Enabled color
          },
        ),
      ),
      child: const  Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Add padding here
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
          backgroundColor: answered[index] ? Colors.deepPurple.shade100 : Colors.deepPurple,
          child: answered[index]
              ? const Icon(Icons.check, color: Colors.white)
              : Text((index + 1).toString(), style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  CircleAvatar buildBackButton(BoxConstraints constraints) {
    return CircleAvatar(
      radius: constraints.maxWidth * 0.1,
      child: IconButton(
        onPressed: () {
          if (currentPage > 0) { // Changed to 0 since the first page is 0
            setState(() {
              currentPage--;
            });
            _pageController.previousPage(duration: const Duration(seconds: 2), curve: Curves.decelerate);
          }
        },
        icon: Icon(Icons.arrow_back_ios_new, size: constraints.maxWidth * 0.1),
      ),
    );
  }

  CircleAvatar buildForwardButton(BoxConstraints constraints) {
    return CircleAvatar(
      radius: constraints.maxWidth * 0.1,
      child: IconButton(
        onPressed: () {
          if (currentPage < 6) { // Changed to 6 since the last page is 6 (index 6)
            setState(() {
              currentPage++;
            });
            _pageController.nextPage(duration: const Duration(seconds: 2), curve: Curves.decelerate);
          }
        },
        icon: Icon(Icons.arrow_forward_ios_sharp, size: constraints.maxWidth * 0.1),
      ),
    );
  }
}
