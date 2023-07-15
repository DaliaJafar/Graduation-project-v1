import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:firebase_login_app/Models/tutor.dart';
import 'package:firebase_login_app/Screens/home_screen.dart';
import 'package:firebase_login_app/Screens/login_screen.dart';
import 'package:firebase_login_app/Screens/tutor_navigation_screen.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'navigation_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var user = FirebaseAuth.instance.currentUser;
            Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            print(userData['role']);
           

            
            print("Hello Home Screen");
            if (userData['role'] == 'student') {
            return const NavigationScreen();
            }
            else{
              return const NavigationTutorScreen();
            }
          } else {
            print("Hello User Screen");
            return const LogInScreen();
          }
        },
      ),
    );
  }

  // Future<DocumentSnapshot> getUserData() async {
  //   DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
  //   return userRef.get();
  // }
}
