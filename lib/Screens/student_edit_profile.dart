import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StudentEditProfileUI(),
    );
  }
}

class StudentEditProfileUI extends StatefulWidget {
  const StudentEditProfileUI({Key? key}) : super(key: key);

  @override
  State<StudentEditProfileUI> createState() => _StudentEditProfileUIState();
}

class _StudentEditProfileUIState extends State<StudentEditProfileUI> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text("Flutter Edit Profile UI"),
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context); // Go back to previous screen
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Edit Profile "),
          actions: [
            IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout))
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: getUserData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error occurred: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(
                child: Text('User data not found.'),
              );
            }

            // User data exists
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    const Text(
                      "User Information",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField("Full Name", userData['name'], false),
                    buildTextField("Email", userData['email'], false),
                    buildTextField("Password", "********", true),
                    buildTextField("Location", userData['location'], false),
                    buildTextField("Phone", userData['phone'], false),
                    //      buildTextField("Role", userData['role'], false),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildTextField(
      String labelText, String placeHolder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscurePassword = !isObscurePassword;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
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
