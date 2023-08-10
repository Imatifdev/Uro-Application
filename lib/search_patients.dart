// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:uroapplication/view/admin/searchpatient.dart';

// import '../models/usermodel.dart';

// class SearchPatient extends StatefulWidget {
//   @override
//   _SearchPatientState createState() => _SearchPatientState();
// }

// class _SearchPatientState extends State<SearchPatient>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   logOut() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Do you want to log out?'),
//           actions: [
//             TextButton(
//               child: const Text('Log Out'),
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 //Navigator.of(context).pushNamedAndRemoveUntil(AuthHome.idScreen,(boolo){return false;});
//               },
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.red),
//                 ))
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         //  floatingActionButton: FloatingActionButton(onPressed: (){logOut();}, child: const Icon(Icons.logout, color: Colors.white,)),
//         appBar: AppBar(
//           title: const Text('Search Record',
//               style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
//         ),
//         body: Tab1Widget()
//         // bottomNavigationBar: TabBar(
//         //   controller: _tabController,
//         //   tabs: const [
//         //     Tab(icon: Icon(Icons.people),text: "Customers",),
//         //     Tab(icon: Icon(Icons.person_4_sharp), text: "Drivers",),
//         //     Tab(icon: Icon(Icons.car_repair), text: "Rides"),
//         //   ],
//         // ),
//         );
//   }
// }

// class Tab1Widget extends StatefulWidget {
//   const Tab1Widget({super.key});

//   @override
//   State<Tab1Widget> createState() => _Tab1WidgetState();
// }

// class _Tab1WidgetState extends State<Tab1Widget> {
//   List<String> customers = [];
//   List<UserModel> users = [];
//   List<String> searchResults = [];
//   int heightCheck = 0;
//   TextEditingController controller = TextEditingController();
//   void search(String query) {
//     setState(() {
//       heightCheck = 250;
//       searchResults = customers
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//       if (controller.text.isEmpty) {
//         searchResults = [];
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget _buildListItem(UserModel user) {
//       return Card(
//         child: ListTile(
//           title: Text(user.fname),
//         ),
//       );
//     }

//     Widget _buildList(QuerySnapshot<Object?>? snapshot) {
//       if (snapshot!.docs.isEmpty) {
//         return const Center(child: Text("No Users !"));
//       } else {
//         List customer = [];
//         customers = [];
//         snapshot.docs.forEach((doc) {
//           Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
//           // if (data!['Role']  == 'Customer') {
//           customer.add(doc);
//           customers.add(data!["First Name"]);
//           //}
//         });
//         //   print("riderrrrrrrzzzz: $customers");
//         return ListView.builder(
//           itemCount: customer.length,
//           itemBuilder: (context, index) {
//             final doc = customer[index];
//             final user = UserModel.fromSnapshot(doc);
//             return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DisplayRecordPage(customer[index]),
//                     ),
//                   );
//                 },
//                 child: _buildListItem(user));
//           },
//         );
//       }
//     }

//     return SafeArea(
//         child: SizedBox(
//       width: double.infinity,
//       child: Column(children: [
//         const Text(
//           "Patients",
//           style: TextStyle(fontSize: 18),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: TextField(
//             controller: controller,
//             onChanged: (value) => search(value),
//             decoration: const InputDecoration(
//               labelText: 'Search',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: searchResults.isEmpty ? 0 : heightCheck.toDouble(),
//           child: ListView.builder(
//             itemCount: searchResults.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(searchResults[index]),
//                 onTap: () {
//                   setState(() {
//                     searchResults = [];
//                     heightCheck = 0;
//                   });
//                 },
//               );
//             },
//           ),
//         ),
//         StreamBuilder<QuerySnapshot>(
//             stream:
//                 FirebaseFirestore.instance.collection("Patients").snapshots(),
//             builder: ((context, snapshot) {
//               if (!snapshot.hasData) return const LinearProgressIndicator();
//               return Expanded(child: _buildList(snapshot.data));
//             })),
//       ]),
//     ));
//   }
// }
