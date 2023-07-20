import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fname;
  final String email;
  const UserModel({
    this.id,
    required this.email,
    required this.fname,
  });

  toJson() {
    return {
      'First Name': fname,
      'Email': email,
    };
  }

  //map for fecthing users from firestore
  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return UserModel(
      id: document.id,
      email: data['Email'],
      fname: data['First Name'],
    );
  }
}
