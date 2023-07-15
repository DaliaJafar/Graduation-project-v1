import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:firebase_login_app/Controllers/sessions_controller.dart';

import '../Models/tutor.dart';

class RequestInputsScreen extends StatefulWidget {
  Tutor tutorObject;
  DateTime date;
  RequestInputsScreen({required this.date, Key? key, required this.tutorObject})
      : super(key: key);

  @override
  _RequestInputsState createState() => _RequestInputsState();
}

class _RequestInputsState extends State<RequestInputsScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  static const List<String> hours = <String>[
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours'
  ];
  TextEditingController location_controller = TextEditingController();
  DateTime _dateTime = DateTime.now();
  String period = hours.first;

  @override
  void initState() {
    print('RequestInputsScreen');
    print(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Study Session'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topPortion('Request your study session'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  // Text('Time '),
                  Text(widget.date.toString()),
                  timePicker(),
                  const SizedBox(
                    height: 50,
                  ),
                  DropdownButton(
                    value: period,
                    items: hours.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        period = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: location_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: 'Location',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                TextButton(onPressed: () {}, child: const Text('Cancel')),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                // TextButton(onPressed: () {}, child: const Text('Request')),
                FloatingActionButton.extended(
                  onPressed: () {
                    confirm_dialog();
                  },
                  elevation: 0,
                  label: const Text("Request Session"),
                  icon: const Icon(Icons.schedule_send_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget timePicker() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: const TextStyle(
          fontSize: 16, color: Color.fromARGB(130, 106, 104, 103)),
      highlightedTextStyle:
          const TextStyle(fontSize: 24, color: Color.fromARGB(255, 17, 17, 16)),
      spacing: 20,
      itemHeight: 40,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  confirm_dialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure to Request ?"),
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
                  addSession(
                      widget.date,
                      location_controller.text,
                      period,
                      _dateTime,
                      widget.tutorObject.id,
                      userId,
                      widget.tutorObject.subject);
                });
                Navigator.of(context).pop();

                final snackBar = SnackBar(
                  content: Text('Study Session requested Successfully'),
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
                "Request",
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
