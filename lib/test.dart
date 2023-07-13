import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Constants/firestore.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // getData() async {
  //   firebaseFirestore.collection('users').where('role',isEqualTo: 'tutor').get().then((value) {
  //     value.docs.forEach((element) {
  //       print(element.data());
  //       print('------------------------------');
  //     });
  //   });
  // }

  // _addUserToFirestore(String userId) {
  //   firebaseFirestore.collection('users').doc(userId).set({
  //     "email": "sama@gmail.com",
  //     "location": "ramallah",
  //     "name": "Sama",
  //     "phone": "33",
  //     "role": "student",
  //     "student_id": userId
  //   });
  // }

  // @override
  // // void initState() {
  // //   getData();
  // //   super.initState();
  // // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // _addUserToFirestore('188');
            // getData();
          },
          child: Text('hi'),
        ),
      ),
    );
  }
}
