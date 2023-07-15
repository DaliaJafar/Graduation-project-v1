import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Models/session.dart';
import 'package:firebase_login_app/Screens/studySession_request_screen.dart';
import 'package:flutter/material.dart';
import '../Controllers/sessions_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestedSessionsScreen extends StatefulWidget {
  const RequestedSessionsScreen({Key? key}) : super(key: key);

  @override
  _RequestedSessionsState createState() => _RequestedSessionsState();
}

class _RequestedSessionsState extends State<RequestedSessionsScreen> {
  // final _selectedColor = Color.fromRGBO(156, 39, 176, 1);
  // final _unselectedColor = Color(0xff5f6368);
  String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Flutter TabBar Example - Customized "),
          ),
          body: Container(
            child: upcomingSessions(getPendingSessionsTutor(userId)),
          )),
    );
  }

  Widget upcomingSessions(Stream<QuerySnapshot> getData) {
    return StreamBuilder<QuerySnapshot>(
      stream: getData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final documents = snapshot.data!.docs;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 197, 182, 197),
                  elevation: 10,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          // leading:
                          // const CircleAvatar(
                          //   radius:
                          //       35, // Adjust the radius as per your preference
                          //   backgroundImage: NetworkImage(
                          //       'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'), // Replace with your image URL or use AssetImage for local images
                          // ),
                          title: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FutureBuilder<String>(
                              future: getTutorName(document),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('');
                                } else if (snapshot.hasData) {
                                  return Text(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text('No tutor name available');
                                }
                              },
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(document['subject'] +
                                "\n\n" +
                                document['date'].toString()),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            onPressed: () {
                              print('clicked');
                              StudySession studySession =
                                  intializeStudySessionModel(document);
                              print(studySession.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StudySessionRequestScreen(
                                              studySession: studySession)));
                              // Fluttertoast.showToast(
                              //   msg: "Study Session Approved Successfully",
                              //   toastLength: Toast.LENGTH_LONG,
                              //   gravity: ToastGravity.CENTER,
                              //   timeInSecForIosWeb: 1,
                              //   backgroundColor: Colors.red,
                              //   textColor: Colors.white,
                              //   fontSize: 16.0,
                              // );
                              // setState(() {
                              //   confirm_dialog(document, documents);
                              // });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  StudySession intializeStudySessionModel(QueryDocumentSnapshot document) {
    StudySession studySession = StudySession(
        date: document['date'] ?? Timestamp.now(),
        location: document['location'] ?? '',
        period: document['period'] ?? '',
        sessionId: document['session_id'] ?? '',
        status: document['status'] ?? '',
        studentId: document['student_id'] ?? '',
        subject: document['subject'] ?? '',
        time: document['time'] ?? '',
        tutorId: document['tutor_id'] ?? '');
    return studySession;
  }

  confirm_dialog(QueryDocumentSnapshot document,
      List<QueryDocumentSnapshot<Object?>> documents) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to approve this study session?"),
          actions: <Widget>[
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 141, 138, 141))),
              onPressed: () {
                print('canceled');

                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.purple)),
              onPressed: () {
                setState(() {
                  updateSessionStatus(document);
                  documents.remove(document);
                  print('approved');
                });
                Navigator.of(context).pop();

                final snackBar = SnackBar(
                  content: Text('Srudy Session Approved Successfully'),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Perform some action when the user presses the "Undo" button.
                    },
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                "Approve",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
