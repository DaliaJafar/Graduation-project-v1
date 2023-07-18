import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getReviews(String tutorId) {
  return FirebaseFirestore.instance
      .collection('feedback')
      .where('tutor_id', isEqualTo: tutorId)
      .snapshots();
}

// Future<String> getStudentName(QueryDocumentSnapshot<Object?> doc) async {
//   String studentName = '';
//   var studentId = doc['student_id'];
//   QuerySnapshot snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .where('student_id', isEqualTo: studentId)
//       .get();
//   if (snapshot.size > 0) {
//     studentName = snapshot.docs[0]['name'];
//     print('Student Name: $studentName');
//     return studentName;
//   }
//   return studentName;
// }

Future<void> addReview(
    String tutorId, double rating, String feedback, String studentId) async {
  try {
    // Create a new document in the 'feedback' collection
    await FirebaseFirestore.instance.collection('feedback').add({
      'tutor_id': tutorId,
      'rating': rating,
      'feedback': feedback,
      'student_id': studentId,
    });

    print('Review added successfully');
  } catch (e) {
    print('Failed to add review: $e');
    // Handle the error accordingly
  }
}

Future<double> avgRates(String tutorId) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('feedback')
      .where('tutor_id', isEqualTo: tutorId)
      .get();

  double sum = 0;
  double avg = 0;
  for (var doc in snapshot.docs) {
    var data = doc.data();
    if (data['rating'] != null) {
      double rate = data['rating'];
      sum += rate;
    }
  }
  avg = sum / snapshot.docs.length;

  return avg;
}
