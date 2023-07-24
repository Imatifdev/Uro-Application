// ignore_for_file: unused_local_variable, depend_on_referenced_packages, library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controller/mycolors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<List<DocumentSnapshot>> _searchResults = Future.value([]);

  void _performSearch(String query) {
    setState(() {
      _searchResults = _searchData(query);
    });
  }

  Future<List<DocumentSnapshot>> _searchData(String query) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Patients")
        .where("First Name", isGreaterThanOrEqualTo: query)
        .where("First Name", isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Container(
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: [blue, darkblue])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  size: 40,
                  color: const Color.fromARGB(255, 58, 49, 49),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _performSearch,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: _searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // Navigate to a new page to display the whole record.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DisplayRecordPage(snapshot.data![index]),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index]["First Name"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Divider(
                                  thickness: 0.5,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayRecordPage extends StatelessWidget {
  final DocumentSnapshot record;

  const DisplayRecordPage(this.record, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Patient Record",
              style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            _buildRecordTile(Icons.person, 'First Name', record['First Name']),
            _buildRecordTile(Icons.person, 'Last Name', record['Last Name']),
            _buildRecordTile(Icons.email, 'Email', record['Email']),
            _buildRecordTile(Icons.calendar_today, 'DOB', record['DOB']),
            _buildRecordTile(Icons.phone, 'Phone', record['Phone']),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordTile(IconData iconData, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white, // Tile background color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: ListTile(
          trailing: Icon(CupertinoIcons.right_chevron),
          leading: Icon(iconData, color: Colors.blue),
          title: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Text(subtitle, style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
