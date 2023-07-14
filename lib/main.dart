// import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_app/Screens/edit_profile_old.dart';
import 'package:firebase_login_app/Screens/login_screen.dart';
import 'package:firebase_login_app/Screens/requestedSessions_screen.dart';
// import 'package:firebase_login_app/Screens/requested_session_dialog.dart';
import 'package:firebase_login_app/Screens/search_screen.dart';
import 'package:firebase_login_app/Screens/requestInputs_screen.dart';
import 'package:firebase_login_app/Screens/upcomingSessions_screen%20copy.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:firebase_login_app/firebase_options.dart';
import 'package:firebase_login_app/test.dart';
import 'package:flutter/material.dart';
import 'Screens/edit_screen.dart';
import 'Screens/home_screen_test.dart';
import 'Screens/map_screen.dart';
import 'Screens/navigation_screen.dart';
import 'Screens/profile.dart';
import 'Screens/profile_from_search_screen.dart';
import 'Screens/calender_screen.dart';
import 'Screens/studySession_request_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: EditProfileUI(),
    );
  }
}
