import 'package:firebase_login_app/Components/widgets.dart';
import 'package:firebase_login_app/Controllers/sessions_controller.dart';
import 'package:firebase_login_app/Models/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class StudySessionRequestScreen extends StatefulWidget {
  final StudySession studySession;
  const StudySessionRequestScreen({required this.studySession, Key? key})
      : super(key: key);

  @override
  _StudySessionRequestScreenState createState() =>
      _StudySessionRequestScreenState();
}

class _StudySessionRequestScreenState extends State<StudySessionRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 228, 243),
      appBar: AppBar(
        title: const Text("Flutter "),
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
                    nameText(
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
                    const SizedBox(width: 15),
                    Text(widget.studySession.date.toString(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined),
                    timePicker(DateTime(2017, 9, 7, 17, 30)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 15),
                    Text(widget.studySession.location.toString(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 18)),
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
                    child: const Text('Reject')),
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
                    child: const Text('Approve')),
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

  Widget nameText(BuildContext context, String uid) {
    return Row(children: [
      Container(
        width: 25,
        height: 25,
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

          // if (!snapshot.hasData || !snapshot.data!.exists) {
          //   return Center(
          //     child: Text('User data not found.'),
          //   );
          // }

          // User data exists
          String userData = snapshot.data!;
          return Text(userData);
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
              onPressed: () {
                updateSessionStatusBySessionId(
                    studySession.sessionId.toString());
                // setState(() {
                //   updateSessionStatusBySessionId(
                //       studySession.sessionId.toString());
                //   print('approved');
                // });
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
              onPressed: () {
                deleteSessionBySessionId(studySession.sessionId.toString());

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
