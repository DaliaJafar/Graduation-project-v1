import 'package:firebase_login_app/Components/widgets.dart';
import 'package:firebase_login_app/Controllers/sessions_controller.dart';
import 'package:firebase_login_app/Models/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class StudySessionDetailsScreen extends StatefulWidget {
  final StudySession studySession;
  const StudySessionDetailsScreen({required this.studySession, Key? key})
      : super(key: key);

  @override
  _StudySessionDetailsScreenState createState() =>
      _StudySessionDetailsScreenState();
}

class _StudySessionDetailsScreenState extends State<StudySessionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormat.format(widget.studySession.date.toDate());

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
                    Text(formattedDate.toString(),
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
        future: getTutorName111(uid),
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
}
