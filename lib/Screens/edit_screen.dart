import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/tutor_controller.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const EditProfileUI(),
    );
  }
}

class EditProfileUI extends StatefulWidget {
  const EditProfileUI({Key? key}) : super(key: key);

  @override
  State<EditProfileUI> createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  bool isObscurePassword = true;
  TutorController tutorController = TutorController();

  TextEditingController name_textController = TextEditingController();
  TextEditingController experience_textController = TextEditingController();

  TextEditingController password_textController = TextEditingController();

  TextEditingController qualification_textController = TextEditingController();

  TextEditingController hourlyRate_textController = TextEditingController();

  final user_id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Edit Profile UI"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Go back to previous screen
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: getUserData(user_id),
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
            // String name = userData['name'];
            // String email = userData['email'];
            // String password = "***";
            // String location = userData['location'];
            // String experience = userData['experience'];
            // String hourly_rate = "${userData['hourly_rate']}\$";
            // String phone = userData['phone'];
            // String subject = userData['subject'];
            // String qualification = userData['qualification'];

            return Container(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  userData['profile_picture'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.purple,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField("Full Name", userData['name'], false,
                        name_textController),
                    // buildTextField("Email", email, false),
                    buildTextField(
                        "Password", "********", true, password_textController),
                    // buildTextField("Location", location, false),
                    buildTextField("Experience", userData['experience'], false,
                        experience_textController),
                    buildTextField("Hourly_Rate", userData['hourly_rate'],
                        false, hourlyRate_textController),
                    // buildTextField("Phone", phone, false),
                    // buildTextField("Subject", subject, false),
                    buildTextField("Qualification", userData['qualification'],
                        false, qualification_textController),
                    // buildTextField("Role", userData['role'], false),
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
                          onPressed: () {
                            //name
                            // name_textController.text.isNotEmpty
                            //     ? tutorController.updateTutorName(
                            //         user_id, name_textController.text)
                            //     : tutorController.updateTutorName(
                            //         user_id, name);
                            if (name_textController.text.isNotEmpty) {
                              tutorController.updateTutorName(
                                  user_id, name_textController.text);
                            }
                            //experience
                            if (experience_textController.text.isNotEmpty) {
                              tutorController.updateTutorExperience(
                                  user_id, experience_textController.text);
                            }

                            //hourlyrate
                            if (hourlyRate_textController.text.isNotEmpty) {
                              tutorController.updateTutorHourlyRate(
                                  user_id, hourlyRate_textController.text);
                            }

                            //qualification
                            if (qualification_textController.text.isNotEmpty) {
                              tutorController.updateTutorQualification(
                                  user_id, qualification_textController.text);
                            }

                            //password
                            if (password_textController.text.isNotEmpty) {
                              tutorController.updateTutorQualification(
                                  user_id, password_textController.text);
                            }

                            Fluttertoast.showToast(
                              msg: 'Saving completed',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
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

  Widget buildTextField(String labelText, String placeHolder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
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
}
