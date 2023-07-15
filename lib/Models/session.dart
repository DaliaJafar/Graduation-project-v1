import 'package:cloud_firestore/cloud_firestore.dart';

class StudySession {
  final Timestamp date;
  final String? location;
  final String? period;
  final String? sessionId;
  final String? status;
  final String? studentId;
  final String? subject;
  final Timestamp? time;
  final String? tutorId;

  StudySession(
      {required this.date,
      this.location,
      this.period,
      this.sessionId,
      this.status,
      this.studentId,
      this.subject,
      this.time,
      this.tutorId});

  // StudySession.fromJson(Map<String, dynamic> json) {
  //   date = json['date'];
  //   location = json['location'];
  //   period = json['period'];
  //   sessionId = json['session_id'];
  //   status = json['status'];
  //   studentId = json['student_id'];
  //   subject = json['subject'];
  //   time = json['time'];
  //   tutorId = json['tutor_id'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['location'] = this.location;
    data['period'] = this.period;
    data['session_id'] = this.sessionId;
    data['status'] = this.status;
    data['student_id'] = this.studentId;
    data['subject'] = this.subject;
    data['time'] = this.time;
    data['tutor_id'] = this.tutorId;
    return data;
  }

  List<StudySession> mapStudySessions(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot document) {
      return StudySession(
        date: document['date'],
        location: document['location'],
        period: document['period'],
        sessionId: document['session_id'],
        status: document['status'],
        studentId: document['student_id'],
        subject: document['subject'],
        time: document['time'],
        tutorId: document['tutor_id'],
      );
    }).toList();
  }

  @override
  String toString() {
    return 'StudySession{'
        'date: $date, '
        'location: $location, '
        'period: $period, '
        'sessionId: $sessionId, '
        'status: $status, '
        'studentId: $studentId, '
        'subject: $subject, '
        'time: $time, '
        'tutorId: $tutorId'
        '}';
  }
}
