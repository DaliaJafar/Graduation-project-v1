import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tutor {
  final String id;
  final String name;
  final String location;
  final String subject;
  final String hourly_rate;
  final String email;
  final String phone;
  final String experience;
  final String profile_pic;
  final String role;
  final String qualification;
  final String token ; 

  const Tutor({
    required this.id,
    required this.name,
    required this.location,
    required this.subject,
    required this.hourly_rate,
    required this.email,
    required this.phone,
    required this.experience,
    required this.profile_pic,
    required this.role,
    required this.qualification,
    required this.token
  });
  // factory Tutor.fromSnapshow(DocumentSnapshot<Map<String,dynamic>> document){
  //   final data = document.data()!;
  //   return Tutor(id: document.id ,tutorName: data['name'], subjectName: data['subject'], phoneNumber: data['phone'], address: data['location'], hourlyRate: data['hourly_rate'], role: data['role']);
  // }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.tutorName;
  //   data['subject'] = this.subjectName;
  //   data['phone'] = this.phoneNumber;
  //   data['location'] = this.address;
  //   data['hourly_rate'] = this.hourlyRate;
  //   data['role'] = this.role;
  //   return data;
  // }
}

// List<Tutor> allTutors = [
//   Tutor(
//       tutorName: "Mostafa Hameda",
//       subjectName: "Arabic",
//       phoneNumber: "0598893219",
//       address: "Ramallah",
//       hourlyRate: 44,
//       role: "tutor"),
//   Tutor(
//       tutorName: "Ahmad",
//       subjectName: "English",
//       phoneNumber: "0599999999",
//       address: "Nablus",
//       hourlyRate: 44,
//       role: "tutor"),
//   Tutor(
//       tutorName: "Mohammed",
//       subjectName: "Arabic",
//       phoneNumber: "0599666999",
//       address: "Jericho",
//       hourlyRate: 44,
//       role: "tutor"),
//   Tutor(
//       tutorName: "Dalia",
//       subjectName: "Arabic",
//       phoneNumber: "0599666999",
//       address: "Ramallah",
//       hourlyRate: 90,
//       role: "tutor"),
//   Tutor(
//       tutorName: "Yafa",
//       subjectName: "History",
//       phoneNumber: "0599666999",
//       address: "Jenin",
//       hourlyRate: 44,
//       role: "tutor"),
// ];
