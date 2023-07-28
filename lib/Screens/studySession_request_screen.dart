import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Components/widgets.dart';
import 'package:firebase_login_app/Controllers/NotificationController.dart';
import 'package:firebase_login_app/Controllers/sessions_controller.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:firebase_login_app/Models/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class StudySessionRequestScreen extends StatefulWidget {
  final StudySession studySession;
  const StudySessionRequestScreen({required this.studySession, Key? key})
      : super(key: key);

  @override
  _StudySessionRequestScreenState createState() =>
      _StudySessionRequestScreenState();
}

class _StudySessionRequestScreenState extends State<StudySessionRequestScreen> {
  NotificationController notificationController = NotificationController();

  @override
  Widget build(BuildContext context) {
    // final dateFormat = DateFormat('yyyy-MM-dd');
    // final formattedDate = dateFormat.format(widget.studySession.date.toDate());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 228, 243),
      appBar: AppBar(
        title: const Text("Request "),
      ),
      body: Column(
        children: [
          topPortion('Study Session Request'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    left: 0, right: 20, top: 35, bottom: 5),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(175, 166, 63, 167)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nameContainer(
                      context,
                      widget.studySession.studentId.toString(),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    left: 0, right: 20, top: 35, bottom: 5),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(175, 166, 63, 167)),
                child: Text(
                  widget.studySession.subject.toString(),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 18),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin:
                const EdgeInsets.only(left: 0, right: 20, top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width * 0.83,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromARGB(177, 154, 17, 156)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.date_range_outlined),
                    const SizedBox(width: 20),
                    Text(widget.studySession.date,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined),
                    timePicker(widget.studySession.time!.toDate()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 15),
                    Text(widget.studySession.location.toString(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.timelapse_sharp),
                    const SizedBox(width: 20),
                    Text(widget.studySession.period.toString(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      confirm_dialog_reject(widget.studySession);
                    },
                    child:
                        const Text('Reject', style: TextStyle(fontSize: 20))),
                const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      confirm_dialog(widget.studySession);
                    },
                    child:
                        const Text('Approve', style: TextStyle(fontSize: 20))),
                const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nameContainer(BuildContext context, String uid) {
    return Row(children: [
      Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 156, 147, 147),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const Icon(
          Icons.person,
          color: Color.fromARGB(255, 248, 248, 248),
        ),
      ),
      FutureBuilder(
        future: getStudentName111(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          }
          String userData = snapshot.data!;
          return Text(userData,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8), fontSize: 18));
        },
      ),
    ]);
  }

  Widget timePicker(DateTime time) {
    return IgnorePointer(
      ignoring: true,
      child: TimePickerSpinner(
        is24HourMode: false,
        normalTextStyle: const TextStyle(
            fontSize: 1, color: Color.fromARGB(177, 154, 17, 156)),
        highlightedTextStyle: const TextStyle(
            fontSize: 24, color: Color.fromARGB(255, 17, 17, 16)),
        spacing: 7,
        itemHeight: 40,
        isForce2Digits: true,
        time: time,
      ),
    );
  }

  confirm_dialog(StudySession studySession) async {
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
              onPressed: () async {
                updateSessionStatusBySessionId(
                    studySession.sessionId.toString());
                // setState(() {
                //   updateSessionStatusBySessionId(
                //       studySession.sessionId.toString());
                //   print('approved');
                // });

                String f5f5 = await getDeviceToken(
                    widget.studySession.studentId.toString());

                String roa = await getTutorName111(
                    FirebaseAuth.instance.currentUser!.uid);
                notificationController.sendNotification(
                    f5f5, "Approved!!", "${roa} has approved your request ");

                Navigator.of(context).pop();

                final snackBar = SnackBar(
                  content: const Text('Srudy Session Approved Successfully'),
                  duration: const Duration(seconds: 3),
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

  confirm_dialog_reject(StudySession studySession) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to reject this study session?"),
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
              onPressed: () async {
                deleteSessionBySessionId(studySession.sessionId.toString());

                String f5f5 = await getDeviceToken(
                    widget.studySession.studentId.toString());

                String roa = await getTutorName111(
                    FirebaseAuth.instance.currentUser!.uid);
                notificationController.sendNotification(
                    f5f5, "Rejected!!", "${roa} has rejected your request ");

                Navigator.of(context).pop();

                final snackBar = SnackBar(
                  content: const Text('Srudy Session rejected'),
                  duration: const Duration(seconds: 3),
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
                "Reject",
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
