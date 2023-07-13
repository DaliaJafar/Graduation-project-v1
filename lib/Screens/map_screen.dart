import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:firebase_login_app/Models/tutor.dart';
import 'package:firebase_login_app/Screens/profile_from_search_screen%20copy.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  List<Map<String, dynamic>> items;
  String subject;
  MapScreen({super.key, required this.items, required this.subject});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var myMarkers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google map"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getTutorsDataBasedOnSubject(widget.subject),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs;
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(31.898043, 35.204269), zoom: 9),
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    for (var i = 0; i < documents.length; i++) {
                      print(documents[i]['name']);
                      myMarkers.add(Marker(
                        markerId: MarkerId(i.toString()),
                        position: LatLng(double.parse(documents[i]['long']),
                            double.parse(documents[i]['lat'])),
                        infoWindow: InfoWindow(
                            title: documents[i]['name'],
                            snippet: documents[i]['subject'] + " Tutor",
                            anchor: Offset(1, 0),
                            onTap: () {
                              Tutor tutor = Tutor(
                                  email: documents[i]['email'],
                                  experience: documents[i]['experience'],
                                  hourly_rate: documents[i]['hourly_rate'],
                                  id: documents[i]['tutor_id'],
                                  location: documents[i]['location'],
                                  name: documents[i]['name'],
                                  phone: documents[i]['phone'],
                                  profile_pic: documents[i]['profile_picture'],
                                  qualification: documents[i]['qualification'],
                                  role: documents[i]['role'],
                                  subject: documents[i]['subject']);
                              print(documents[i]['subject']);
                              print(documents[i]['name']);
                              print("window clicked");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage1Copy(
                                      tutorObject: tutor,
                                    ),
                                  ));
                            }),
                        onTap: () {
                          print("Hello");
                        },
                      ));
                    }
                  });
                },
                markers: myMarkers,
              ),
            ],
          );
        },
      ),
    );
  }
}