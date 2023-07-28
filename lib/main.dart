// import 'dart:html';
//import 'dart:js_util';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:firebase_login_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
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
      home: UserTypeScreen(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

Future<void> _firebaseMessagingForegroundHandler(RemoteMessage message) async {
  print('Foreground Notification:');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');

  // Handle the received notification here
  // Perform any necessary actions, such as displaying a custom UI, updating data, or navigating to a specific screen
}
