import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/Models/session.dart';
import 'package:firebase_login_app/Models/session.dart';

import 'firebase_controller.dart';

Stream<QuerySnapshot> getAllSessions() {
  return FirebaseFirestore.instance.collection('study_session').snapshots();
}

Stream<QuerySnapshot> getPendingSessions(String studentId) {
  return FirebaseFirestore.instance
      .collection('study_session')
      .where('status', isEqualTo: 'pending')
      .where('student_id', isEqualTo: studentId)
      .snapshots();
}

Stream<QuerySnapshot> getPendingSessionsTutor(String tutorId) {
  return FirebaseFirestore.instance
      .collection('study_session')
      .where('status', isEqualTo: 'pending')
      .where('tutor_id', isEqualTo: tutorId)
      .snapshots();
}

Stream<QuerySnapshot> getUpcomingSessions(String studentId) {
  return FirebaseFirestore.instance
      .collection('study_session')
      .where('status', isEqualTo: 'upcoming')
      .where('student_id', isEqualTo: studentId)
      .snapshots();
}

Stream<QuerySnapshot> getUpcomingSessionsTutor(String tutorId) {
  return FirebaseFirestore.instance
      .collection('study_session')
      .where('status', isEqualTo: 'upcoming')
      .where('tutor_id', isEqualTo: tutorId)
      .snapshots();
}

Stream<QuerySnapshot> getUpcomingSessionsByDate(DateTime date) {
  print('getUpcomingSessionsByDate');
  print(date);
  return FirebaseFirestore.instance
      .collection('study_session')
      .where('status', isEqualTo: 'upcoming')
      .where('date', isEqualTo: date)
      .snapshots();
}

Future<String> getTutorName(QueryDocumentSnapshot<Object?> doc) async {
  String tutorName = '';
  var tutorId = doc['tutor_id'];
  print('Tutor id: $tutorId');
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('tutor_id', isEqualTo: tutorId)
      .where('role', isEqualTo: 'tutor')
      .get();
  if (snapshot.size > 0) {
    print('hi');
    tutorName = snapshot.docs[0]['name'];
    print('Tutor Name: $tutorName');
    return tutorName;
  }
  print(tutorName + '5');
  return tutorName;
}

Future<String> getStudentName111(String studentId) async {
  String studentName = '';
  // var studentId = doc['student_id'];
  print(studentId);
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('student_id', isEqualTo: studentId)
      .where('role', isEqualTo: 'student')
      .get();
  print('hi');
  if (snapshot.size > 0) {
    print('if');
    studentName = snapshot.docs[0]['name'];
    print('Student Name: $studentName');
    return studentName;
  }
  return studentName;
}

Future<String> getTutorName111(String tutotId) async {
  String tutorName = '';
  // var studentId = doc['student_id'];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('tutor_id', isEqualTo: tutotId)
      .where('role', isEqualTo: 'tutor')
      .get();
  print('hi');
  if (snapshot.size > 0) {
    print('if');
    tutorName = snapshot.docs[0]['name'];
    print('Student Name: $tutorName');
    return tutorName;
  }
  return tutorName;
}

void addSession(DateTime day, String location, String period, DateTime time,
    String tutorId, String studentId, String subject) {
  FireBaseController().firebaseFirestore.collection('study_session').doc().set({
    "date": day,
    "location": location,
    "period": period,
    "session_id": "66",
    "status": "pending",
    "student_id": studentId,
    "subject": subject,
    "time": time,
    "tutor_id": tutorId,
  });
}

// Future<List<StudySession>> getListOfStudySessions_byDate(DateTime date) async {
//   StudySession studySession = StudySession();
//   QuerySnapshot snapshot = await FirebaseFirestore.instance
//       .collection('study_session')
//       .where('status', isEqualTo: 'upcoming')
//       .where('tutor_id', isEqualTo: '444')
//       .where('date', isEqualTo: date)
//       .get();
//   List<StudySession> studySessionsList =
//       studySession.mapStudySessions(snapshot);
//   return studySessionsList;
// }

void updateSessionStatus(QueryDocumentSnapshot<Object?> document) async {
  DocumentReference<Object?> docRef = document.reference;
  await docRef.update({'status': 'upcoming'});
  print('updated');
  print(document['status']);
}

void updateSessionStatusBySessionId(String sessionId) async {
  print('session id');
  print("." + sessionId);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> collectionRef =
      firestore.collection('study_session');
  DocumentReference<Object?> documentRef = collectionRef.doc(sessionId);
  print('hi');

  await documentRef.update({'status': 'upcoming'});
}

void deleteSession(QueryDocumentSnapshot<Object?> document) async {
  DocumentReference<Object?> docRef = document.reference;
  await docRef.delete();
  print('deleted');
}

void deleteSessionBySessionId(String sessionId) async {
  print('session id');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> collectionRef =
      firestore.collection('study_session');
  DocumentReference<Object?> documentRef = collectionRef.doc(sessionId);
  print('hi');

  await documentRef.delete();
}

Future<List<DateTime>> getDatesOfSessions() async {
  final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('study_session')
      .where('status', isEqualTo: 'upcoming')
      .get();

  final List<DateTime> upcomingDates = [];

  for (var doc in snapshot.docs) {
    print(snapshot.docs.length);
    var data = doc.data();
    print(data);
    if (data['date'] != null) {
      print('is date');
      final Timestamp timestamp = data['date']!;
      final DateTime sessionDate = timestamp.toDate();
      upcomingDates.add(sessionDate);
    }
  }

  return upcomingDates;
}
