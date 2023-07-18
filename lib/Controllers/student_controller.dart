import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getStudentName(DocumentSnapshot item) async {
  final data = item.data() as Map<String, dynamic>?;

  if (data != null && data.containsKey('student_id')) {
    final studentId = data['student_id'] as String?;

    if (studentId != null) {
      final studentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(studentId)
          .get();

      final studentData = studentSnapshot.data() as Map<String, dynamic>?;

      if (studentData != null && studentData.containsKey('name')) {
        return studentData['name'] as String;
      }
    }
  }

  return 'Unknown Student';
}

