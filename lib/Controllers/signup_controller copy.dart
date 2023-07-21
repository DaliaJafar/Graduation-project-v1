import 'package:firebase_login_app/Controllers/firebase_controller.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_login_app/Components/dialogs.dart';

class SignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<UserCredential?> signUpTutor(
    BuildContext context,
    String email,
    String username,
    String password,
    String location,
    String phone,
    String role,
    String experience,
    String qualification,
    String subject,
    double hourlyRate,
    String profilePicture,
    String long,
    String lat,
  ) async {
    var formdata = formState.currentState;

    if (formdata!.validate()) {
      formdata.save();

      print('valid');

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        print(userCredential.user?.emailVerified);

        if (userCredential.user?.emailVerified == false) {
          User? user = FirebaseAuth.instance.currentUser;

          await user?.sendEmailVerification();
        }

        if (userCredential.user?.emailVerified == false) {
          awesome_dialog(
                  context,
                  const Text(
                      'Please check your email and click the verification link to complete the sign-up process'))
              .show();
        }

        _addTutorToFirestore(
            userCredential.user!.uid,
            email,
            username,
            location,
            phone,
            role,
            experience,
            qualification,
            subject,
            hourlyRate,
            profilePicture,
            long,
            lat);

        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          awesome_dialog(context, const Text('too weak password')).show();

          print('too weak');
        } else if (e.code == 'email-already-in-use') {
          awesome_dialog(context, const Text('email is already in use')).show();

          print('already in use');
        } else if (e.code == 'network-request-failed') {
          awesome_dialog(context, const Text('Please verify your email'))
              .show();

          print('User not verified');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('not valid');
    }

    return null;
  }

  Future<UserCredential?> signUpStudent(
    BuildContext context,
    String email,
    String username,
    String password,
    String location,
    String phone,
    String role,
  ) async {
    var formdata = formState.currentState;

    if (formdata!.validate()) {
      formdata.save();

      print('valid');

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        print(userCredential.user?.emailVerified);

        if (userCredential.user?.emailVerified == false) {
          User? user = FirebaseAuth.instance.currentUser;

          await user?.sendEmailVerification();
        }

        if (userCredential.user?.emailVerified == false) {
          awesome_dialog(
                  context,
                  const Text(
                      'Please check your email and click the verification link to complete the sign-up process'))
              .show();
        }

        _addStudentToFirestore(
            userCredential.user!.uid, email, username, location, phone, role);

        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          awesome_dialog(context, const Text('too weak password')).show();

          print('too weak');
        } else if (e.code == 'email-already-in-use') {
          awesome_dialog(context, const Text('email is already in use')).show();

          print('already in use');
        } else if (e.code == 'network-request-failed') {
          awesome_dialog(context, const Text('Please verify your email'))
              .show();

          print('User not verified');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('not valid');
    }

    return null;
  }

  _addStudentToFirestore(String userId, String email, String username,
      String location, String phone, String role) {
    FireBaseController().firebaseFirestore.collection('users').doc(userId).set({
      "email": email,
      "location": location,
      "name": username,
      "phone": phone,
      "role": role,
      "student_id": userId
    });
  }

  _addTutorToFirestore(
      String userId,
      String email,
      String username,
      String location,
      String phone,
      String role,
      String experience,
      String qualification,
      String subject,
      double hourlyRate,
      var profilePicture,
      String long,
      String lat) {
    FireBaseController().firebaseFirestore.collection('users').doc(userId).set({
      "email": email,
      "experience": experience,
      "hourly_rate": hourlyRate,
      "location": location,
      "name": username,
      "phone": phone,
      "profile_picture": profilePicture,
      "qualification": qualification,
      "role": role,
      "subject": subject,
      "tutor_id": userId,
      "user_id": userId,
      "long": long,
      "lat": lat
    });
  }
}
