// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_login_app/Models/tutor.dart';
// import 'package:firebase_login_app/Screens/requestInputs_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
//     show CalendarCarousel;
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
// import 'package:intl/intl.dart' show DateFormat;
// import 'package:firebase_login_app/Controllers/sessions_controller.dart';

// class CalenderScreen extends StatefulWidget {
//   final Tutor tutorObject;
//   CalenderScreen({Key? key, required this.tutorObject}) : super(key: key);

//   @override
//   _CalenderState createState() => new _CalenderState();
// }

// class _CalenderState extends State<CalenderScreen> {
//   Future<List<DateTime>> list = getDatesOfSessions();
//   List<DateTime> upcomingDates = [];
//   List<Event> eventsOfTheDay = [];
//   DateTime _dateTime = DateTime.now();
//   DateTime _currentDate = DateTime(2023, 2, 3);
//   String _currentMonth = DateFormat.yMMM().format(DateTime(2023, 2, 3));
//   DateTime _targetDateTime = DateTime(2018, 9, 20);
//   // List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
//   static final Widget _eventIcon = Container(
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(1000)),
//         border: Border.all(color: Colors.blue, width: 4.0)),
//   );

//   final EventList<Event> _markedDateMap = EventList<Event>(
//     events: {
//       DateTime(2022, 2, 10): [
//         Event(
//           date: DateTime(2022, 2, 10),
//           title: 'Event 1',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Color.fromARGB(255, 111, 244, 54),
//             height: 1.0,
//             width: 1.0,
//           ),
//         ),
//         Event(
//           date: DateTime(2022, 2, 10),
//           title: 'Event 2',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Color.fromARGB(255, 111, 244, 54),
//             height: 1.0,
//             width: 1.0,
//           ),
//         ),
//         Event(
//           date: DateTime(2022, 2, 5),
//           title: 'Event 3',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Color.fromARGB(255, 111, 244, 54),
//             height: 1.0,
//             width: 1.0,
//           ),
//         ),
//         Event(
//           date: DateTime(2022, 2, 4),
//           title: 'Event 3',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Color.fromARGB(255, 111, 244, 54),
//             height: 1.0,
//             width: 1.0,
//           ),
//         ),
//         Event(
//           date: DateTime(2023, 2, 26),
//           title: 'Event 3',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Color.fromARGB(255, 111, 244, 54),
//             height: 1.0,
//             width: 1.0,
//           ),
//         ),
//         Event(
//           date: DateTime(2023, 2, 26),
//           title: 'Event 3',
//           icon: _eventIcon,
//           dot: Container(
//             margin: EdgeInsets.symmetric(horizontal: 1.0),
//             color: Color.fromARGB(255, 111, 244, 54),
//             height: 1.0,
//             width: 1.0,
//           ),
//         ),
//       ],
//     },
//   );

//   // late EventList<Event> _markedDateMap = EventList<Event>(events: {});

//   // EventList<Event> _markedDateMap1 = EventList<Event>(events: {});
//   // void addEvents() {
//   //   list.then((dates) {
//   //     for (var date in dates) {
//   //       _markedDateMap1.add(
//   //         date,
//   //         Event(date: date, title: 'Event', icon: _eventIcon),
//   //       );
//   //     }
//   //   });
//   // }

//   void getDates() async {
//     upcomingDates = await getDatesOfSessions();
//     print('date!!');
//     print(upcomingDates);
//   }

//   @override
//   void initState() {
//     getDates();
//     // getMarkedDates(upcomingDates);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Sessions'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                       child: Text(
//                     _currentMonth,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24.0,
//                     ),
//                   )),
//                   TextButton(
//                     child: Text('PREV'),
//                     onPressed: () {
//                       setState(() {
//                         _targetDateTime = DateTime(
//                             _targetDateTime.year, _targetDateTime.month - 1);
//                         _currentMonth =
//                             DateFormat.yMMM().format(_targetDateTime);
//                       });
//                     },
//                   ),
//                   TextButton(
//                     child: Text('NEXT'),
//                     onPressed: () {
//                       setState(() {
//                         _targetDateTime = DateTime(
//                             _targetDateTime.year, _targetDateTime.month + 1);
//                         _currentMonth =
//                             DateFormat.yMMM().format(_targetDateTime);
//                       });
//                     },
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 child: Container(
//                   // margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: calendar(),
//                 ),
//               ),
//               eventsOfTheDay.length == 0
//                   ? Container()
//                   : SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.5,
//                       child:
//                           // StreamBuilder<QuerySnapshot>(
//                           //       stream: getUpcomingSessionsByDate(_targetDateTime),
//                           //       builder: (context, snapshot) {
//                           //         if (!snapshot.hasData) {
//                           //           return const CircularProgressIndicator();
//                           //         }
//                           //         final documents = snapshot.data!.docs;
//                           //         return Padding(
//                           //           padding: const EdgeInsets.all(8.0),
//                           //           child: ListView.builder(
//                           //             itemCount: documents.length,
//                           //             itemBuilder: (context, index) {
//                           //               final document = documents[index];
//                           //               return Padding(
//                           //                 padding: const EdgeInsets.all(8.0),
//                           //                 child: Card(
//                           //                   shape: RoundedRectangleBorder(
//                           //                     borderRadius: BorderRadius.circular(15.0),
//                           //                   ),
//                           //                   color: Color.fromARGB(255, 197, 182, 197),
//                           //                   elevation: 10,
//                           //                   child: Column(
//                           //                     // mainAxisSize: MainAxisSize.min,
//                           //                     children: <Widget>[
//                           //                       Padding(
//                           //                         padding: const EdgeInsets.all(10.0),
//                           //                         child: ListTile(
//                           //                           // leading: ,
//                           //                           title: Text(document['date']),
//                           //                           subtitle: Text(document['period']),
//                           //                         ),
//                           //                       ),
//                           //                     ],
//                           //                   ),
//                           //                 ),
//                           //               );
//                           //             },
//                           //           ),
//                           //         );
//                           //       },
//                           //     )
//                           ListView.builder(
//                         itemCount: eventsOfTheDay.length,
//                         itemBuilder: (context, index) {
//                           final event = eventsOfTheDay[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Color.fromARGB(255, 106, 102, 102),
//                                 ),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: ListTile(
//                                 contentPadding: const EdgeInsets.all(5.0),
//                                 leading: Text(''),
//                                 title: Text(
//                                     '${event.date.day}/${event.date.month}/${event.date.year}'),
//                                 subtitle: Text('eventsOfTheDay'),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: FloatingActionButton.extended(
//                   onPressed: () {
//                     print('onPressed');
//                     print(_targetDateTime);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => RequestInputsScreen(
//                                   date: _targetDateTime,
//                                   tutorObject: widget.tutorObject,
//                                 )));
//                   },
//                   elevation: 0,
//                   label: const Text("Request Session"),
//                   icon: const Icon(Icons.schedule_send_outlined),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   Widget calendar() {
//     return CalendarCarousel<Event>(
//       todayBorderColor: Colors.green,
//       onDayPressed: (date, events) {
//         setState(() {
//           print('date in set state');
//           print(date);
//           _targetDateTime = date;
//           print('_targetDateTime');
//           print(_targetDateTime);
//           // eventsOfTheDay.clear();
//           eventsOfTheDay.add(Event(date: date));
//           eventsOfTheDay.add(Event(date: date));
//           // _showSessionsDialog(date);
//           // eventsOfTheDay.add(Event(date: date));
//         });
//         print('day pressed !');

//         print(_targetDateTime);
//         // _currentDate = date;
//         // _showSessionsDialog(date);

//         events.forEach((event) => print(event.title));
//       },
//       daysHaveCircularBorder: true,
//       showOnlyCurrentMonthDate: false,
//       weekendTextStyle: const TextStyle(
//         color: Colors.black,
//       ),
//       thisMonthDayBorderColor: Colors.grey,
//       weekFormat: false,
// //      firstDayOfWeek: 4,
//       markedDatesMap: _markedDateMap,
//       height: 520.0,
//       selectedDateTime: _currentDate,
//       targetDateTime: _targetDateTime,
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       markedDateCustomShapeBorder:
//           CircleBorder(side: BorderSide(color: Colors.yellow)),
//       markedDateCustomTextStyle: const TextStyle(
//         fontSize: 18,
//         color: Color.fromARGB(255, 8, 8, 8),
//       ),
//       showHeader: false,
//       todayTextStyle: const TextStyle(
//         color: Color.fromARGB(255, 8, 8, 8),
//       ),
//       //markedDateShowIcon: true,
//       // markedDateIconMaxShown: 2,
//       // markedDateIconBuilder: (event) {
//       //   return event.icon;
//       // },
//       markedDateMoreShowTotal: true,
//       todayButtonColor: Colors.yellow,
//       selectedDayTextStyle: const TextStyle(
//         color: Colors.yellow,
//       ),
//       minSelectedDate: _currentDate.subtract(Duration(days: 360)),
//       maxSelectedDate: _currentDate.add(Duration(days: 360)),
//       prevDaysTextStyle: const TextStyle(
//         fontSize: 16,
//         color: Colors.pinkAccent,
//       ),
//       inactiveDaysTextStyle: const TextStyle(
//         // color: Colors.tealAccent,
//         fontSize: 16,
//       ),
//       onCalendarChanged: (DateTime date) {
//         setState(() {
//           _currentDate = date;
//           _currentMonth = DateFormat.yMMM().format(_currentDate);
//         });
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );
//   }

//   Widget timePicker() {
//     return TimePickerSpinner(
//       is24HourMode: false,
//       normalTextStyle: const TextStyle(
//           fontSize: 16, color: Color.fromARGB(130, 106, 104, 103)),
//       highlightedTextStyle:
//           const TextStyle(fontSize: 24, color: Color.fromARGB(255, 17, 17, 16)),
//       spacing: 20,
//       itemHeight: 40,
//       isForce2Digits: true,
//       onTimeChange: (time) {
//         setState(() {
//           _dateTime = time;
//         });
//       },
//     );
//   }

//   _showSessionsDialog(DateTime date) async {
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Color.fromARGB(255, 243, 242, 243),
//         title: Text('Sessions'),
//         content: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.5,
//           child: StreamBuilder<QuerySnapshot>(
//             stream: getUpcomingSessionsByDate(date),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const CircularProgressIndicator();
//               }
//               final documents = snapshot.data!.docs;
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView.builder(
//                   itemCount: documents.length,
//                   itemBuilder: (context, index) {
//                     final document = documents[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(6.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Color.fromARGB(255, 106, 102, 102),
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(5.0),
//                           leading: Text(''),
//                           title: Text(document.toString()
//                               // '${document.date.day}/${document.date.month}/${document.date.year}'
//                               ),
//                           subtitle: Text('eventsOfTheDay'),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//           //   ListView.builder(
//           //     itemCount: eventsOfTheDay.length,
//           //     itemBuilder: (context, index) {
//           //       final event = eventsOfTheDay[index];
//           //       return Padding(
//           //         padding: const EdgeInsets.all(6.0),
//           //         child: Container(
//           //           decoration: BoxDecoration(
//           //             border: Border.all(
//           //               color: Color.fromARGB(255, 106, 102, 102),
//           //             ),
//           //             borderRadius: BorderRadius.all(Radius.circular(50)),
//           //           ),
//           //           child: ListTile(
//           //             contentPadding: const EdgeInsets.all(5.0),
//           //             leading: Text(''),
//           //             title: Text(
//           //                 '${event.date.day}/${event.date.month}/${event.date.year}'),
//           //             subtitle: Text('eventsOfTheDay'),
//           //           ),
//           //         ),
//           //       );
//           //     },
//           //   ),
//           // ),
//           // Padding(
//           //   padding: const EdgeInsets.all(20.0),
//           //   child: FloatingActionButton.extended(
//           //     onPressed: () {
//           //       Navigator.push(
//           //           context,
//           //           MaterialPageRoute(
//           //               builder: (context) => RequestInputsScreen(
//           //                     date: _targetDateTime.toString(),
//           //                   )));
//           //     },
//           //     elevation: 0,
//           //     label: const Text("Request Session"),
//           //     icon: const Icon(Icons.schedule_send_outlined),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }

//   // _showAddDialog(DateTime day) async {
//   //   await showDialog(
//   //       context: context,
//   //       builder: (context) => AlertDialog(
//   //             backgroundColor: Color.fromARGB(255, 243, 242, 243),
//   //             title: Text("Request Study session"),
//   //             content: SizedBox(
//   //               height: MediaQuery.of(context).size.width * 0.8,
//   //               child: Column(
//   //                 children: [
//   //                   Text('Time '),
//   //                   timePicker(),
//   //                   DropdownButton(
//   //                     value: hour_value,
//   //                     items:
//   //                         hours.map<DropdownMenuItem<String>>((String value) {
//   //                       return DropdownMenuItem<String>(
//   //                         value: value,
//   //                         child: Text(value),
//   //                       );
//   //                     }).toList(),
//   //                     onChanged: (String? value) {
//   //                       // This is called when the user selects an item.
//   //                       setState(() {
//   //                         hour_value = value!;
//   //                         print(hour_value);
//   //                       });
//   //                     },
//   //                   ),
//   //                   SizedBox(
//   //                     height: 20,
//   //                   ),
//   //                   // reusableTextFormField(
//   //                   //     'time', Icons.timeline, false, time_controller, ''),
//   //                   // // reusableTextFormField('location', Icons.location_pin,
//   //                   // //     false, time_controller, ''),

//   //                   // SizedBox(
//   //                   //   height: 10,
//   //                   // ),
//   //                   // reusableTextFormField('location', Icons.location_pin, false,
//   //                   //     time_controller, ''),
//   //                   // Column(
//   //                   //   children: [
//   //                   //     ListTile(
//   //                   //       title: Text('Full Name'),
//   //                   //       subtitle:
//   //                   TextFormField(
//   //                     controller: location_controller,
//   //                     decoration: const InputDecoration(
//   //                       border: OutlineInputBorder(
//   //                           borderRadius:
//   //                               BorderRadius.all(Radius.circular(20))),
//   //                       hintText: 'Location',
//   //                     ),
//   //                   ),
//   //                   //
//   //                   SizedBox(
//   //                     height: 5,
//   //                   ),
//   //                   // Row(
//   //                   //   children: [
//   //                   //     Expanded(
//   //                   //       child: ListTile(
//   //                   //         title: Text('Department'),
//   //                   //         subtitle: TextFormField(
//   //                   //           decoration: const InputDecoration(
//   //                   //             border: OutlineInputBorder(
//   //                   //                 borderRadius: BorderRadius.all(
//   //                   //                     Radius.circular(8))),
//   //                   //             hintText: '  Department',
//   //                   //           ),
//   //                   //         ),
//   //                   //       ),
//   //                   //     ),
//   //                   //     SizedBox(
//   //                   //       width: 5,
//   //                   //     ),
//   //                   //     Expanded(
//   //                   //       child: ListTile(
//   //                   //         title: Text('Year Of Study'),
//   //                   //         subtitle: TextFormField(
//   //                   //           decoration: const InputDecoration(
//   //                   //             border: OutlineInputBorder(
//   //                   //                 borderRadius: BorderRadius.all(
//   //                   //                     Radius.circular(8))),
//   //                   //             hintText: '  Year Of Study',
//   //                   //           ),
//   //                   //         ),
//   //                   //       ),
//   //                   //     ),
//   //                   //   ],
//   //                   // )
//   //                   //   ],
//   //                   // ),
//   //                 ],
//   //               ),
//   //             ),
//   //             actions: <Widget>[
//   //               ElevatedButton(
//   //                 style: const ButtonStyle(
//   //                     backgroundColor:
//   //                         MaterialStatePropertyAll<Color>(Colors.purple)),
//   //                 child: const Text(
//   //                   "Request",
//   //                   style: TextStyle(
//   //                       color: Color.fromARGB(255, 255, 255, 255),
//   //                       fontWeight: FontWeight.bold),
//   //                 ),
//   //                 onPressed: () {
//   //                   // addSession(
//   //                   //     day, location_controller.text, hour_value, _dateTime);
//   //                   // if (_eventController.text.isEmpty) return;
//   //                   // setState(() {
//   //                   //   if (_events[_controller.selectedDay] != null) {
//   //                   //     _events[_controller.selectedDay]
//   //                   //         .add(_eventController.text);
//   //                   //   } else {
//   //                   //     _events[_controller.selectedDay] = [
//   //                   //       _eventController.text
//   //                   //     ];
//   //                   //   }
//   //                   //   _eventController.clear();
//   //                   //   Navigator.pop(context);
//   //                   // });
//   //                 },
//   //               )
//   //             ],
//   //           ));
//   // }

//   // Container(
//   //   padding: EdgeInsets.only(left: 30),
//   //   width: MediaQuery.of(context).size.width,
//   //   height: MediaQuery.of(context).size.height * 0.55,
//   //   decoration: BoxDecoration(
//   //     borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
//   //     color: Color(0xff30384c),
//   //   ),
//   // )

//   // eventsOfTheDay.length == 0
//   //     ? Container()
//   //     :
//   //     Container(
//   //         height: MediaQuery.of(context).size.height * 0.5,
//   //         child: ListView.builder(
//   //           itemCount: eventsOfTheDay.length,
//   //           itemBuilder: (context, index) {
//   //             final event = eventsOfTheDay[index];
//   //             return Padding(
//   //               padding: const EdgeInsets.all(8.0),
//   //               child: Container(
//   //                 decoration: BoxDecoration(
//   //                   border: Border.all(
//   //                     color: Colors.black,
//   //                   ),
//   //                   borderRadius:
//   //                       BorderRadius.all(Radius.circular(10)),
//   //                 ),
//   //                 child: ListTile(
//   //                   contentPadding: const EdgeInsets.all(20.0),
//   //                   leading: Text('event'),
//   //                   title: Text(event.date.toString()),
//   //                   subtitle: Text('eventsOfTheDay'),
//   //                 ),
//   //               ),
//   //             );
//   //           },
//   //         ),
//   //       ),

//   //

// }

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/Screens/requestInputs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:firebase_login_app/Controllers/sessions_controller.dart';

import '../Models/tutor.dart';

class CalenderScreen extends StatefulWidget {
  final Tutor tutorObject;
  CalenderScreen({Key? key, required this.tutorObject}) : super(key: key);

  @override
  _CalenderState createState() => new _CalenderState();
}

class _CalenderState extends State<CalenderScreen> {
  List<DateTime> upcomingDates = [];
  List<Event> eventsOfTheDay = [];
  TextEditingController location_controller = TextEditingController();
  DateTime _dateTime = DateTime.now();
  DateTime _currentDate = DateTime(2023, 2, 3);
  DateTime _currentDate2 = DateTime(2023, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2023, 2, 3));
  DateTime _targetDateTime = DateTime(2018, 9, 20);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      DateTime(2022, 2, 10): [
        new Event(
          date: new DateTime(2022, 2, 2),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: const Color.fromARGB(255, 111, 244, 54),
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2022, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2022, 3, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2022, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        )
      ],
    },
  );

  // late EventList<Event> _markedDateMap = EventList<Event>(events: {});

  void getMarkedDates(List<DateTime> upcomingDates) async {
    print('before');
    for (DateTime date in upcomingDates) {
      print('in for');
      _markedDateMap.add(
          date,
          Event(
            date: date,
            title: 'Event',
            icon: _eventIcon,
            dot: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              color: const Color.fromARGB(255, 111, 244, 54),
              height: 5.0,
              width: 5.0,
            ),
          ));
    }
  }

  void getDates() async {
    upcomingDates = await getDatesOfSessions();
    print('date!!');
    print(upcomingDates);
  }

  @override
  void initState() {
    _markedDateMap.add(
        new DateTime(2022, 2, 25),
        new Event(
          date: new DateTime(2022, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    getDates();
    // getMarkedDates(upcomingDates);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Study Sessions'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _currentMonth,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  )),
                  TextButton(
                    child: const Text('PREV'),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month - 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  ),
                  TextButton(
                    child: const Text('NEXT'),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: calendar(),
                ),
              ),
              // eventsOfTheDay.length == 0
              //     ? Container()
              //     :
              StreamBuilder<QuerySnapshot>(
                stream: getUpcomingSessionsByDate(
                    _currentDate2, widget.tutorObject.id), // Pass the stream here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for data to arrive
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    // If there's an error with the stream
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    // If data is available
                    final dates =
                        snapshot.data?.docs ?? []; // Get the list of documents
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          final date = dates[index];
                          final Timestamp timestamp = date['time']!;
                          // final DateTime dateTime = date['date']!;

                          String formattedTime =
                              DateFormat('HH:mm').format(timestamp.toDate());

                          return ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors
                                    .blue, // Customize the color of the leading icon
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons
                                    .event, // You can change the icon to your preference
                                color: Colors
                                    .white, // Customize the color of the icon
                              ),
                            ),
                            title: Text(
                              '${_currentDate2.day}/${_currentDate2.month}/${_currentDate2.year}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),

              // SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.2,
              //     child: ListView.builder(
              //       itemCount: eventsOfTheDay.length,
              //       itemBuilder: (context, index) {
              //         final event = eventsOfTheDay[index];
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 8.0, horizontal: 16.0),
              //           child: Container(
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               border: Border.all(
              //                 color: Colors.grey.withOpacity(0.5),
              //                 width: 2.0,
              //               ),
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10)),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.grey.withOpacity(0.3),
              //                   blurRadius: 4,
              //                   spreadRadius: 2,
              //                   offset: const Offset(0, 2),
              //                 ),
              //               ],
              //             ),
              //             child: ListTile(
              //               contentPadding: const EdgeInsets.all(16.0),
              //               leading: Container(
              //                 width: 40,
              //                 height: 40,
              //                 decoration: const BoxDecoration(
              //                   color: Colors
              //                       .blue, // Customize the color of the leading icon
              //                   shape: BoxShape.circle,
              //                 ),
              //                 alignment: Alignment.center,
              //                 child: const Icon(
              //                   Icons
              //                       .event, // You can change the icon to your preference
              //                   color: Colors
              //                       .white, // Customize the color of the icon
              //                 ),
              //               ),
              //               title: Text(
              //                 '${event.date.day}/${event.date.month}/${event.date.year}',
              //                 style: const TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               subtitle: const Text(
              //                 '3:30 pm',
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestInputsScreen(
                                  date: _currentDate2,
                                  tutorObject: widget.tutorObject,
                                )));
                  },
                  elevation: 0,
                  label: const Text("Request Session"),
                  icon: const Icon(Icons.schedule_send_outlined),
                ),
              ),
            ],
          ),
        ));
  }

  Widget calendar() {
    return CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        setState(() {
          print('date in set state');
          print(date);
          _targetDateTime = date;
          print('_targetDateTime');
          print(_targetDateTime);
          eventsOfTheDay.clear();
          eventsOfTheDay.add(Event(date: date));
          // eventsOfTheDay.add(Event(date: date));
          // _showSessionsDialog(date);
          // eventsOfTheDay.add(Event(date: date));
        });
        print('day pressed !');
        setState(() {
          _currentDate2 = date;
          // _showSessionsDialog(date);
        });
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 520.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          const CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromARGB(255, 8, 8, 8),
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Color.fromARGB(255, 8, 8, 8),
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: const TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: const TextStyle(
        // color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
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

  // _showSessionsDialog(DateTime date) async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: const Color.fromARGB(255, 243, 242, 243),
  //       title: const Text('Sessions'),
  //       content: SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.5,
  //         child: StreamBuilder<QuerySnapshot>(
  //           stream: getUpcomingSessionsByDate(date),
  //           builder: (context, snapshot) {
  //             if (!snapshot.hasData) {
  //               return const CircularProgressIndicator();
  //             }
  //             final documents = snapshot.data!.docs;
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: ListView.builder(
  //                 itemCount: documents.length,
  //                 itemBuilder: (context, index) {
  //                   final document = documents[index];
  //                   return Padding(
  //                     padding: const EdgeInsets.all(6.0),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: const Color.fromARGB(255, 106, 102, 102),
  //                         ),
  //                         borderRadius:
  //                             const BorderRadius.all(Radius.circular(50)),
  //                       ),
  //                       child: ListTile(
  //                         contentPadding: const EdgeInsets.all(5.0),
  //                         leading: const Text(''),
  //                         title: Text(document.toString()
  //                             // '${document.date.day}/${document.date.month}/${document.date.year}'
  //                             ),
  //                         subtitle: const Text('eventsOfTheDay'),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             );
  //           },
  //         ),
          //   ListView.builder(
          //     itemCount: eventsOfTheDay.length,
          //     itemBuilder: (context, index) {
          //       final event = eventsOfTheDay[index];
          //       return Padding(
          //         padding: const EdgeInsets.all(6.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: Color.fromARGB(255, 106, 102, 102),
          //             ),
          //             borderRadius: BorderRadius.all(Radius.circular(50)),
          //           ),
          //           child: ListTile(
          //             contentPadding: const EdgeInsets.all(5.0),
          //             leading: Text(''),
          //             title: Text(
          //                 '${event.date.day}/${event.date.month}/${event.date.year}'),
          //             subtitle: Text('eventsOfTheDay'),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: FloatingActionButton.extended(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => RequestInputsScreen(
          //                     date: _targetDateTime.toString(),
          //                   )));
          //     },
          //     elevation: 0,
          //     label: const Text("Request Session"),
          //     icon: const Icon(Icons.schedule_send_outlined),
          //   ),
          // ),
  //       ),
  //     ),
  //   );
  // }

  // _showAddDialog(DateTime day) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             backgroundColor: Color.fromARGB(255, 243, 242, 243),
  //             title: Text("Request Study session"),
  //             content: SizedBox(
  //               height: MediaQuery.of(context).size.width * 0.8,
  //               child: Column(
  //                 children: [
  //                   Text('Time '),
  //                   timePicker(),
  //                   DropdownButton(
  //                     value: hour_value,
  //                     items:
  //                         hours.map<DropdownMenuItem<String>>((String value) {
  //                       return DropdownMenuItem<String>(
  //                         value: value,
  //                         child: Text(value),
  //                       );
  //                     }).toList(),
  //                     onChanged: (String? value) {
  //                       // This is called when the user selects an item.
  //                       setState(() {
  //                         hour_value = value!;
  //                         print(hour_value);
  //                       });
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   // reusableTextFormField(
  //                   //     'time', Icons.timeline, false, time_controller, ''),
  //                   // // reusableTextFormField('location', Icons.location_pin,
  //                   // //     false, time_controller, ''),

  //                   // SizedBox(
  //                   //   height: 10,
  //                   // ),
  //                   // reusableTextFormField('location', Icons.location_pin, false,
  //                   //     time_controller, ''),
  //                   // Column(
  //                   //   children: [
  //                   //     ListTile(
  //                   //       title: Text('Full Name'),
  //                   //       subtitle:
  //                   TextFormField(
  //                     controller: location_controller,
  //                     decoration: const InputDecoration(
  //                       border: OutlineInputBorder(
  //                           borderRadius:
  //                               BorderRadius.all(Radius.circular(20))),
  //                       hintText: 'Location',
  //                     ),
  //                   ),
  //                   //
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   // Row(
  //                   //   children: [
  //                   //     Expanded(
  //                   //       child: ListTile(
  //                   //         title: Text('Department'),
  //                   //         subtitle: TextFormField(
  //                   //           decoration: const InputDecoration(
  //                   //             border: OutlineInputBorder(
  //                   //                 borderRadius: BorderRadius.all(
  //                   //                     Radius.circular(8))),
  //                   //             hintText: '  Department',
  //                   //           ),
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //     SizedBox(
  //                   //       width: 5,
  //                   //     ),
  //                   //     Expanded(
  //                   //       child: ListTile(
  //                   //         title: Text('Year Of Study'),
  //                   //         subtitle: TextFormField(
  //                   //           decoration: const InputDecoration(
  //                   //             border: OutlineInputBorder(
  //                   //                 borderRadius: BorderRadius.all(
  //                   //                     Radius.circular(8))),
  //                   //             hintText: '  Year Of Study',
  //                   //           ),
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //   ],
  //                   // )
  //                   //   ],
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             actions: <Widget>[
  //               ElevatedButton(
  //                 style: const ButtonStyle(
  //                     backgroundColor:
  //                         MaterialStatePropertyAll<Color>(Colors.purple)),
  //                 child: const Text(
  //                   "Request",
  //                   style: TextStyle(
  //                       color: Color.fromARGB(255, 255, 255, 255),
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //                 onPressed: () {
  //                   // addSession(
  //                   //     day, location_controller.text, hour_value, _dateTime);
  //                   // if (_eventController.text.isEmpty) return;
  //                   // setState(() {
  //                   //   if (_events[_controller.selectedDay] != null) {
  //                   //     _events[_controller.selectedDay]
  //                   //         .add(_eventController.text);
  //                   //   } else {
  //                   //     _events[_controller.selectedDay] = [
  //                   //       _eventController.text
  //                   //     ];
  //                   //   }
  //                   //   _eventController.clear();
  //                   //   Navigator.pop(context);
  //                   // });
  //                 },
  //               )
  //             ],
  //           ));
  // }

  // Container(
  //   padding: EdgeInsets.only(left: 30),
  //   width: MediaQuery.of(context).size.width,
  //   height: MediaQuery.of(context).size.height * 0.55,
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
  //     color: Color(0xff30384c),
  //   ),
  // )

  // eventsOfTheDay.length == 0
  //     ? Container()
  //     :
  //     Container(
  //         height: MediaQuery.of(context).size.height * 0.5,
  //         child: ListView.builder(
  //           itemCount: eventsOfTheDay.length,
  //           itemBuilder: (context, index) {
  //             final event = eventsOfTheDay[index];
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     color: Colors.black,
  //                   ),
  //                   borderRadius:
  //                       BorderRadius.all(Radius.circular(10)),
  //                 ),
  //                 child: ListTile(
  //                   contentPadding: const EdgeInsets.all(20.0),
  //                   leading: Text('event'),
  //                   title: Text(event.date.toString()),
  //                   subtitle: Text('eventsOfTheDay'),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),

  //

}
