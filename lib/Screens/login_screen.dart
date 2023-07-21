import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/firebase_controller.dart';
import 'package:firebase_login_app/Screens/main_page.dart';
import 'package:firebase_login_app/Screens/resetpassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login_app/utils/colors_utils.dart';
import 'package:firebase_login_app/Components/widgets.dart';
import 'package:firebase_login_app/Screens/home_screen.dart';

import '../Components/dialogs.dart';

// import 'navigation_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

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
            child: Column(
              children: <Widget>[
                // logoWidget("assets/images/logo1.png"),
                // const SizedBox(
                //   height: 30,
                // ),
                reusableTextFormField("Enter email", Icons.email_outlined,
                    false, _emailTextController, 'email'),
                const SizedBox(
                  height: 20,
                ),

                reusableTextFormField("Enter Password", Icons.lock_outline,
                    true, _passwordTextController, 'password'),
                const SizedBox(
                  height: 5,
                ),
                firebaseUIButton(context, "Log in", () {
                  login();
                }),
                forgetPassword(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    print("login method");
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      if (userCredential.user?.emailVerified == false) {
        // print('not verified user');
        User? user = FirebaseAuth.instance.currentUser;
        user?.delete();
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));

      // print('logged in');
      // print(userCredential.user!.email);

    } on FirebaseAuthException catch (e) {
      // Navigator.pop(context);

      if (e.code == 'user-not-found') {
        print(e.code);
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        print(e.code);
        wrongPasswordMessage();
      } else if (e.code == 'unknown') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Empty fields"),
              content: Text("Please fill it"),
            );
          },
        );
      } else {
        print(e.code);
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("something wrong"),
              content: Text("Please fill it"),
            );
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Email"),
          content: Text("ERROR EMAIL"),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Password"),
          content: Text("ERROR PASS"),
        );
      },
    );
  }
}
