import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/Controllers/reviews_controller.dart';
import 'package:firebase_login_app/Models/tutor.dart';
import 'package:firebase_login_app/Screens/profile_from_search_screen%20copy.dart';
import 'package:firebase_login_app/Screens/profile_from_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_login_app/Controllers/tutor_controller.dart';

import '../Constants/firestore.dart';
import '../Controllers/firebase_controller.dart';

class TutorsList extends StatefulWidget {
  List<Map<String, dynamic>> items;
  String subject;
  TutorsList({
    super.key,
    required this.items,
    required this.subject,
  });

  @override
  State<TutorsList> createState() => _TutorsListState();
}

class _TutorsListState extends State<TutorsList> {
  var test = "";
  List<Map<String, dynamic>> tempList = [];
  List<Map<String, dynamic>> tempItems2 = [];

  String selectedCity = "0";
  double value = 50;
  late Future<double> rate;
  @override
  void initState() {
    super.initState();

    // print(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutors"),
      ),
      drawer: getDrawer(),
      body: SafeArea(
          child: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final tutor = widget.items[index];
              tempItems2.add(widget.items[index]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20.0),
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(tutor['profile_picture']),
                    ),
                    title: Text(tutor['name']),
                    subtitle:
                        Text("${tutor['hourly_rate']} \$\n${tutor['subject']}"),
                    trailing: FutureBuilder(
                      future: avgRates(tutor['tutor_id']),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        return Column(
                          children: [
                            const Icon(
                              Icons.star_rate,
                              color: Color.fromARGB(255, 237, 230, 160),
                            ),
                            Text(snapshot.data.toString()),
                          ],
                        );
                      },
                    ),
                    onTap: () {
                      Tutor tutorObject = Tutor(
                        id: tutor['tutor_id'],
                        name: tutor['name'],
                        location: tutor['location'],
                        subject: tutor['subject'],
                        hourly_rate: tutor['hourly_rate'],
                        email: tutor['email'],
                        phone: tutor['phone'],
                        experience: tutor['experience'],
                        profile_pic: tutor['profile_picture'],
                        role: tutor['role'],
                        qualification: tutor['qualification'],
                      );
                      print(tutorObject.toString());
                      print(tutorObject.email);
                      print(tutorObject.profile_pic);
                      FireBaseController()
                          .firebaseFirestore
                          .collection('users')
                          .where('role', isEqualTo: 'tutor')
                          .where('tutor_id', isEqualTo: tutor['tutor_id'])
                          .orderBy('avg_rate', descending: true)
                          .get();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage1Copy(
                              tutorObject: tutorObject,

                              // subject: subject.subjectName,
                              // items: tempList,
                            ),
                          ));
                    },
                  ),
                ),
              );
              // return Container();
            },
          ),
        )
      ])),
    );
  }

  Widget getDrawer() {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[buildHeader(context), buildMenuItems(context)],
      )),
    );
  }

  buildHeader(BuildContext context) => Container(
        color: Colors.blue.shade700,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(children: [
          Text(
            "List By:",
            style: TextStyle(fontSize: 24, color: Colors.white),
          )
        ]),
      );

  buildMenuItems(BuildContext context) => Column(
        children: [
          const ListTile(
            leading: const Icon(Icons.money),
            title: const Text("Hourly Rate"),
            // onTap: () {
            //   setState(() {
            //     widget.items.sort((a, b) => double.parse(a['hourly_rate'])
            //         .compareTo(double.parse(b['hourly_rate'])));
            //     widget.items.forEach((element) {
            //       print('hourly_rate: ${element['hourly_rate']}');
            //     });
            //   });
            // },
          ),
          Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: 20,
            activeColor: Colors.purple,
            inactiveColor: Colors.red.shade100,
            label: value.round().toString(),
            onChanged: (value) {
              setState(() {
                this.value = value;
                print(value);
              });
            },
          ),
          //  const ListTile(
          //   leading: const Icon(Icons.menu_book),
          //   title: const Text("Experience"),
          //   // onTap: () {
          //   //   setState(() {
          //   //     widget.items.sort((a, b) => double.parse(a['hourly_rate'])
          //   //         .compareTo(double.parse(b['hourly_rate'])));
          //   //     widget.items.forEach((element) {
          //   //       print('hourly_rate: ${element['hourly_rate']}');
          //   //     });
          //   //   });
          //   // },
          // ),
          // Slider(
          //   value: value,
          //   min: 1,
          //   max: 4,
          //   divisions: 1,
          //   activeColor: Colors.purple,
          //   inactiveColor: Colors.red.shade100,
          //   label: value.round().toString(),
          //   onChanged: (value) {
          //     setState(() {
          //       this.value = value;
          //       print(value);
          //     });
          //   },
          // ),

          // const ListTile(
          //   leading: Icon(Icons.location_city),
          //   title: Text("City Name"),
          // ),
          // Center(
          //   child:
          //       Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          //     StreamBuilder<QuerySnapshot>(
          //       stream: FireBaseController()
          //           .firebaseFirestore
          //           .collection('cities')
          //           .snapshots(),
          //       builder: (context, snapshot) {
          //         List<DropdownMenuItem> citiesItems = [];
          //         if (!snapshot.hasData) {
          //           const CircularProgressIndicator();
          //         } else {
          //           final cities = snapshot.data?.docs.reversed.toList();
          //           citiesItems.add(
          //             const DropdownMenuItem(
          //                 value: "0", child: Text("Select City")),
          //           );

          //           for (var city in cities!) {
          //             citiesItems.add(
          //               DropdownMenuItem(
          //                   value: city.id, child: Text(city['city_name'])),
          //             );
          //           }
          //         }
          //         return DropdownButton(
          //           items: citiesItems,
          //           onChanged: (value) {
          //             setState(() {
          //               selectedCity = value;
          //               showDialog(
          //                 context: context,
          //                 builder: (context) {
          //                   return AlertDialog(
          //                     title: Text(value),
          //                     content: Text("ERROR PASS"),
          //                   );
          //                 },
          //               );
          //             });
          //             print(selectedCity);
          //           },
          //           value: selectedCity,
          //           isExpanded: false,
          //         );
          //       },
          //     ),
          //   ]),
          // ),
          FloatingActionButton.extended(
            onPressed: () {
              print(widget.items.length);
              tempList = [];

              for (int i = 0; i < widget.items.length; i++) {
                if (double.parse(widget.items[i]['hourly_rate']) <= value) {
                  tempList.add(widget.items[i]);
                }
              }
              setState(() {
                widget.items = [];
                widget.items = tempList;
              });
            },
            heroTag: 'done',
            elevation: 0,
            backgroundColor: Colors.yellow[700],
            label: const Text("Done"),
            icon: const Icon(Icons.done),
          ),
        ],
      );

  Widget getListBySubject(String subject, dynamic tutor) {
    return subject.compareTo(tutor.subjectName) == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(20.0),
                // elevation: 5,

                // leading: Image.network(

                //  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg',
                //   fit: BoxFit.cover,
                //   width: MediaQuery.of(context).size.width * 0.15,
                //   height: MediaQuery.of(context).size.height * 0.4,

                // ),
                leading: const CircleAvatar(
                  radius: 35, // Adjust the radius as per your preference
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'), // Replace with your image URL or use AssetImage for local images
                ),
                title: Text(tutor['name']),
                subtitle:
                    Text("${tutor['hourly_rate']} \$\n${tutor['subject']}"),
                trailing: Icon(Icons.star_rate),
              ),
            ),
          )
        : Container();
  }
}
