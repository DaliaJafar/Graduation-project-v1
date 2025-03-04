import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_login_app/Models/subject.dart';

import 'package:firebase_login_app/Screens/map_screen.dart';

import 'package:firebase_login_app/Screens/tutors_list_screen.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/widgets/framework.dart';

import '../Constants/firestore.dart';

import '../Controllers/firebase_controller.dart';

class SearchByMapScreen extends StatefulWidget {
  const SearchByMapScreen({super.key});

  @override
  State<SearchByMapScreen> createState() => _SearchByMapScreenState();
}

class _SearchByMapScreenState extends State<SearchByMapScreen> {
  final controller = TextEditingController();

  List<Subject> subjectItems = [];

  List<Subject> foundedItems = [];

  @override
  void initState() {
    fetchSubjectRecords();

    super.initState();
  }

  @override

  // void dispose() {

  //   subjectSubscription?.cancel(); // Cancel the Firestore subscription

  //   super.dispose();

  // }

  fetchSubjectRecords() async {
    FireBaseController()
        .firebaseFirestore
        .collection('subjects')
        .snapshots()
        .listen((snapshot) {
      mapRecords(snapshot);
    });
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var _list = snapshot.docs
        .map(
          (s) => Subject(
            id: s.id,
            subjectName: s['subject'],
          ),
        )
        .toList();

    setState(() {
      subjectItems = _list;

      foundedItems = subjectItems;
    });
  }

  // List<Subject> subjects = allSubjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search By Map"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 50, 16, 50),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Subject Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: const Color(0xFF000000))),
                ),
                onChanged: _runFilter,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundedItems.length,
                itemBuilder: (context, index) {
                  final subject = foundedItems[index];

                  return ListTile(

                      // leading: Image.network(

                      //   subject.urlImage,

                      //   fit: BoxFit.cover,

                      //   width: 50,

                      //   height: 50,

                      // ),

                      title: Text(foundedItems[index].subjectName),
                      onTap: () {
                        FireBaseController()
                            .firebaseFirestore
                            .collection('users')
                            .where('role', isEqualTo: 'tutor')
                            .where('subject',
                                isEqualTo: foundedItems[index].subjectName)
                            .get()
                            .then((value) {
                          List<Map<String, dynamic>> tempList = [];

                          value.docs.forEach((element) {
                            tempList.add(element.data());

                            print(element.data()['tutor_id']);

                            // print('------------------------------');
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  subject: subject.subjectName,
                                  items: tempList,
                                ),
                              ));
                        });
                      });
                },
              ),
            )
          ],
        ));
  }

  void _runFilter(String enteredKeyword) {
    List<Subject> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users

      results = subjectItems;
    } else {
      results = subjectItems
          .where((user) => user.subjectName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive

    }

    // Refresh the UI

    setState(() {
      foundedItems = results;
    });
  }

  // void searchSubject(String query) {

  //   final suggestions = subjectItems.where((subj) {

  //     final subjectName = subj.subjectName.toLowerCase();

  //     final input = query.toLowerCase();

  //     return subjectName.contains(input);

  //   }).toList();

  //   setState(() {

  //     subjectItems = suggestions;

  //     for (var i = 0; i < suggestions.length; i++) {

  //       print(suggestions[i].subjectName);

  //     }

  //   });

  // }

}
