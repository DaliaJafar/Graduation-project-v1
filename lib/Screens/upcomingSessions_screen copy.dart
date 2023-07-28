import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Models/session.dart';
import 'package:firebase_login_app/Screens/login_screen.dart';
import 'package:firebase_login_app/Screens/signup_screen.dart';
import 'package:firebase_login_app/Screens/studySession_details_screen.dart';
import 'package:flutter/material.dart';
import '../Constants/firestore.dart';
import '../Controllers/sessions_controller.dart';
import '../utils/colors_utils.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:intl/intl.dart';

class UpcomingSessionsScreenCopy extends StatefulWidget {
  const UpcomingSessionsScreenCopy({Key? key}) : super(key: key);

  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UpcomingSessionsScreenCopy> {
  // final _selectedColor = Color.fromRGBO(156, 39, 176, 1);
  // final _unselectedColor = Color(0xff5f6368);
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Sessions"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.purple[300],
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Upcoming',
                      ),
                      Tab(
                        text: 'Pending',
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    sessionsList(getUpcomingSessions(userId)),
                    sessionsList(getPendingSessions(userId))
                  ],
                ))
              ],
            ),
          )),
    );
  }

  Widget sessionsList(Stream<QuerySnapshot> getData) {
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
              final String date = document['date']!;
              // final dateFormat = DateFormat('yyyy-MM-dd');
              // final formattedDate = dateFormat.format(timestamp.toDate());
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color.fromARGB(255, 197, 182, 197),
                  elevation: 10,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: FutureBuilder<String>(
                            future: getTutorImage(document[
                                'tutor_id']), // Replace 'tutorId' with the actual tutor ID
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // While waiting for the image URL, you can show a placeholder or a loading indicator
                                return const CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors
                                      .grey, // You can set any placeholder color you like
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data != '') {
                                // If an image URL is available, use it
                                return CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(snapshot.data!),
                                );
                              } else {
                                // If no image URL is available, you can show a default avatar or another placeholder
                                return const CircleAvatar(
                                  radius: 35,
                                  // You can use AssetImage for a local default avatar
                                  backgroundImage:
                                      AssetImage('path/to/default_avatar.png'),
                                );
                              }
                            },
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FutureBuilder<String>(
                              future: getTutorName(document),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('');
                                } else if (snapshot.hasData) {
                                  return Text(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const Text('No tutor name available');
                                }
                              },
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(document['subject'] +
                                "\n\n" +
                                date),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: IconButton(
                              icon: const Icon(Icons.density_small_outlined),
                              onPressed: () {
                                StudySession studySession =
                                    intializeStudySessionModel(document);
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudySessionDetailsScreen(
                                                studySession: studySession,
                                              )));
                                });
                              },
                            ),
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
}
