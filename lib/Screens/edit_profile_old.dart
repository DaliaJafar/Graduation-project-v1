// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_login_app/Controllers/sessions_controller.dart';
// import 'package:firebase_login_app/Controllers/tutor_controller.dart';
// import 'package:firebase_login_app/Models/tutor.dart';
// import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.purple,
// //       ),
// //       home: const EditProfileUI(),
// //     );
// //   }
// // }

// class EditProfileUI extends StatefulWidget {
//   final Tutor tutorObject;

//   const EditProfileUI({required this.tutorObject, Key? key})
//       : super(key: key);

//   @override
//   State<EditProfileUI> createState() => _EditProfileUIState();
// }

// class _EditProfileUIState extends State<EditProfileUI> {
//   final user = FirebaseAuth.instance.currentUser;

//   bool isObscurePassword = true;
//   TutorController tutorController = TutorController();
//   final TextEditingController _hourlyRateController = TextEditingController();
//   String _houtlyRatePlaceHplder = '300'; 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Edit Profile UI"),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context); // Go back to previous screen
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 4, color: Colors.white),
//                         boxShadow: [
//                           BoxShadow(
//                             spreadRadius: 2,
//                             blurRadius: 10,
//                             color: Colors.black.withOpacity(0.1),
//                           ),
//                         ],
//                         shape: BoxShape.circle,
//                         image: const DecorationImage(
//                           image: NetworkImage(
//                             'https://i.ibb.co/CMQ7N0W/6dc35d95-b92b-4d5b-a18f-dabd2795cfac.jpg',
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 4, color: Colors.white),
//                           color: Colors.purple,
//                         ),
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // buildTextField("Full Name", "Mostafa Hameda", false),
//               // // buildTextField("Email", "Hameda@gmail.com", false),
//               // buildTextField("Password", "**********", true),
//               // buildTextField("Location", "BZU", false),
//               // buildTextField("Experience", "10 Years Counter Strike", false),
//               // buildTextField("Hourly_Rate", "100\$", false),
//               // buildTextField("Phone", "0599111999", false),
//               // buildTextField("Subject", "Flutter", false),
//               // buildTextField("Qualification", "Bachelor ", false),
//               // buildTextField("Role", "Tutor", false),
//               const SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 50,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text(
//                       "Cancel",
//                       style: TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 2,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {

//                            tutorController.updateTutorHourlyRate(user!.uid, _hourlyRateController.text);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.purple,
//                       padding: const EdgeInsets.symmetric(horizontal: 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text(
//                       "Save",
//                       style: TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 2,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String labelText, String placeHolder,
//       bool isPasswordTextField, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30),
//       child: TextField(
//         controller: controller,
//         obscureText: isPasswordTextField ? isObscurePassword : false,
//         decoration: InputDecoration(
//           suffixIcon: isPasswordTextField
//               ? IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isObscurePassword = !isObscurePassword;
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.remove_red_eye,
//                     color: Colors.grey,
//                   ),
//                 )
//               : null,
//           contentPadding: const EdgeInsets.only(bottom: 5),
//           labelText: labelText,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: placeHolder,
//           hintStyle: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }
