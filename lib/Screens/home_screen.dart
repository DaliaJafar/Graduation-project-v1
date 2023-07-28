// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_login_app/Controllers/firebase_controller.dart';
// import 'package:firebase_login_app/Controllers/users_controller.dart';
// import 'package:firebase_login_app/Screens/test_screen.dart';
// import 'package:firebase_login_app/Screens/usertype_screen.dart';
// import 'package:firebase_login_app/test.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final user = FirebaseAuth.instance.currentUser!;



//   @override
//   void initState() {
//     requestPermission();
//     getToken() ; 
//     _saveDeviceToken() ; 
//     super.initState();
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//         IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout))
//       ],
//         title: Text('User Details'),
//           automaticallyImplyLeading: false,
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: getUserData(FirebaseAuth.instance.currentUser!.uid),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error occurred: ${snapshot.error}'),
//             );
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(
//               child: Text('User data not found.'),
//             );
//           }

//           // User data exists
//           Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

//           String name = userData['name'];
//           String email = userData['email'];
//           String phone = userData['phone'];
//           String location = userData['location'];

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListTile(
//                 title: Text('Name'),
//                 subtitle: Text(name),
//               ),
//               ListTile(
//                 title: Text('Email'),
//                 subtitle: Text(email),
//               ),
//                ListTile(
//                 title: Text('Phone'),
//                 subtitle: Text(phone),
//               ),
//                ListTile(
//                 title: Text('Location'),
//                 subtitle: Text(location),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }


//   signOutUser() {
//     FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const UserTypeScreen()),
//         (route) => false);
//   }


//   final FirebaseFirestore _db = FirebaseFirestore.instance;
// final FirebaseMessaging _fcm = FirebaseMessaging.instance;
// String deviceToken = " ";

// // Future<void> _firebaseMessagingBackgroundHandler(
// //     RemoteMessage message) async {
// //   // If you're going to use other Firebase services in the background, such as Firestore,
// //   // make sure you call `initializeApp` before using other Firebase services.
// //   await Firebase.initializeApp();

// //   print("Handling a background message: ${message.messageId}");
// // }

// requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   print(settings.authorizationStatus);
// }

// getToken() async {
//   await FirebaseMessaging.instance.getToken().then((value) {
//     setState(() {
//       deviceToken = value!;
//       print('deviceToken is ----> $deviceToken');
//     });
//   });
// }

// /// Get the token, save it to the database for current user
// _saveDeviceToken() async {
//   // Get the current user
//   User? user = await FirebaseAuth.instance.currentUser;
//   String uid = user!.uid; // FirebaseUser user = await _auth.currentUser();
//   // Get the token for this device
//   String? fcmToken = await _fcm.getToken();

//   // Save it to Firestore
//   if (fcmToken != null) {
//     var tokens = _db.collection('users').doc(uid);

//     await tokens.update({
//       'token': fcmToken,
//     });
//   }
// }
// }


//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.

//   print("Handling a background message: ${message.messageId}");
// }

// Future<void> _firebaseMessagingForegroundHandler(RemoteMessage message) async {
//   print('Foreground Notification:');
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');

//   // Handle the received notification here
//   // Perform any necessary actions, such as displaying a custom UI, updating data, or navigating to a specific screen
// }

