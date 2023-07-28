import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/signup_controller%20copy.dart';
import 'package:firebase_login_app/Screens/home_screen_test.dart';
import 'package:firebase_login_app/Screens/tutor_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login_app/utils/colors_utils.dart';
import 'package:firebase_login_app/Components/widgets.dart';
import 'package:firebase_login_app/Screens/home_screen.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

class SignUpScreen extends StatefulWidget {
  String role;
  SignUpScreen({
    super.key,
    required this.role,
  });

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = SignUpController();

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  // var email, password, username;

  // GlobalKey<FormState> formState = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: signUpController.formState,
              child: Column(
                children: <Widget>[
                  // logoWidget("assets/images/logo1.png"),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  reusableTextFormField(
                    "Enter email",
                    Icons.email_outlined,
                    false,
                    _emailTextController,
                    'email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFormField(
                    "Enter UserName",
                    Icons.person_outline,
                    false,
                    _usernameTextController,
                    'username',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Enter Phone number",
                    Icons.phone_outlined,
                    _phoneTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFormField(
                    "Enter Location",
                    Icons.location_pin,
                    false,
                    _locationTextController,
                    'location',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFormField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                    'password',
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  widget.role == 'student'
                      ? firebaseUIButton(context, "Sign up", () async {
                          if (_emailTextController.text.isNotEmpty &&
                              _usernameTextController.text.isNotEmpty &&
                              _passwordTextController.text.isNotEmpty &&
                              _locationTextController.text.isNotEmpty &&
                              _phoneTextController.text.isNotEmpty) {
                            UserCredential? response =
                                await signUpController.signUpStudent(
                              context,
                              _emailTextController.text,
                              _usernameTextController.text,
                              _passwordTextController.text,
                              _locationTextController.text,
                              _phoneTextController.text,
                              widget.role,
                            );
                            if (response != null) {
                              print(response.user?.email);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            }
                          } else {
                            showAlertDialog(context);
                          }
                        })
                      : firebaseUIButton(context, 'next', () {
                          // getPermission();
                          // print(locationData!.longitude);
                          // print(locationData!.latitude);
                          if (_emailTextController.text.isEmpty ||
                              _usernameTextController.text.isEmpty ||
                              _passwordTextController.text.isEmpty ||
                              _locationTextController.text.isEmpty ||
                              _phoneTextController.text.isEmpty) {
                            showAlertDialog(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TutorSignUpScreen(
                                          email: _emailTextController.text,
                                          username:
                                              _usernameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          location:
                                              _locationTextController.text,
                                          phone: _phoneTextController.text,
                                        )));
                          }
                        })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("Please fill all fields"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
