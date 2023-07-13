import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/firebase_controller.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:firebase_login_app/Screens/test_screen.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:firebase_login_app/test.dart';
import 'package:flutter/material.dart';

class TutorHomeScreen extends StatefulWidget {
  const TutorHomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TutorHomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout))
      ],
        title: Text('User Details'),
          automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('User data not found.'),
            );
          }

          // User data exists
          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

          String name = userData['name'];
          String email = userData['email'];
          String phone = userData['phone'];
          String location = userData['location'];
          String hourly_rate = userData['hourly_rate'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Name'),
                subtitle: Text(name),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(email),
              ),
               ListTile(
                title: Text('Phone'),
                subtitle: Text(phone),
              ),
               ListTile(
                title: Text('Location'),
                subtitle: Text(location),
              ),
               ListTile(
                title: Text('Hourly Rate'),
                subtitle: Text(hourly_rate),
              ),
            ],
          );
        },
      ),
    );
  }


  signOutUser() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const UserTypeScreen()),
        (route) => false);
  }
}
