import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class QuizHistoryScreen extends StatelessWidget {
  final String quiz;
  QuizHistoryScreen({required this.quiz});

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('QuizHistory')
            .doc(userId)
            .collection(quiz)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic>? userData =
                    documents[index].data() as Map<String, dynamic>?;
                List<int> selectedAnswers =
                    List<int>.from(userData!['selectedAnswers']);
                int average = userData['sum'];
                DateTime time = (userData['time'] as Timestamp).toDate();

                return ListTile(
                  title: Text('Quiz History ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected Answers: ${selectedAnswers.join(', ')}'),
                      Text('Average: $average'),
                      Text('Time: ${time.toString()}'),
                    ],
                  ),
                  // Customize how you want to display the user data here.
                );
              },
            );
          } else {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noQuizHistory,
              ),
            );
          }
        },
      ),
    );
  }
}

// Usage Example:
// Replace 'YourUserIdHere' with the actual user ID.
// Navigator.push(context, MaterialPageRoute(builder: (context) => QuizHistoryScreen(userId: 'YourUserIdHere')));
