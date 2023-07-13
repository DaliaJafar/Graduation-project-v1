import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestScreen1 extends StatelessWidget {
  const TestScreen1({super.key});
  

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Text("Hello: ${user?.uid!}"),
    );
  }
}