import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/firebase_controller.dart';
import 'package:firebase_login_app/Models/tutor.dart';

import '../Constants/firestore.dart';

class TutorController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateTutorEmail(String email) async {
    try {
      await user!.updateEmail(email);
    } catch (e) {
      print("Failed to update email: $e");
    }
  }

  Future<void> updateTutorPassword(String password) async {
    try {
      await user!.updatePassword(password);
    } catch (e) {
      print("Failed to update pass: $e");
    }
  }

  //has not done yet: email / password / role
  void updateTutorName(String tutorId, String name) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'name': name});
  }

  void updateTutorLocation(String tutorId, String location) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'location': location});
  }

  void updateTutorHourlyRate(String tutorId, String hourlyRate) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'hourly_rate': hourlyRate});
  }

  void updateTutorQualification(String tutorId, String qualification) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'qualification': qualification});
  }

  void updateTutorSubject(String tutorId, String subject) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'subject': subject});
  }

  void updateTutorPhone(String tutorId, String phone) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'phone': phone});
  }

  void updateTutorExperience(String tutorId, String exeprience) async {
    print('tutor id');
    print("." + tutorId);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionRef =
        firestore.collection('users');
    DocumentReference<Object?> documentRef = collectionRef.doc(tutorId);

    await documentRef.update({'exeprience': exeprience});
  }

  // Future<Tutor> getTutorDetails(String email) async {
  //   final snapshot = await FireBaseController().firebaseFirestore
  //       .collection('users')
  //       .where("role", isEqualTo: 'tutor')
  //       .get();
  //   final userData = snapshot.docs.map((e) => Tutor.fromSnapshow(e)).single;
  //   return userData;
  // }

  // Future<List<Tutor>> getAllTutorDetails() async {
  //   final snapshot = await FireBaseController().firebaseFirestore
  //       .collection('users')
  //       .where("role", isEqualTo: 'tutor')
  //       .get();
  //   final userData = snapshot.docs.map((e) => Tutor.fromSnapshow(e)).toList();
  //   return userData;
  // }
}
