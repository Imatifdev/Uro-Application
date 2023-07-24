import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;

  DataModel({this.firstname, this.lastname, this.email, this.phone});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return DataModel(
          firstname: dataMap['First Name'],
          lastname: dataMap['Last Name'],
          email: dataMap['Email'],
          phone: dataMap['Phone']);
    }).toList();
  }
}
