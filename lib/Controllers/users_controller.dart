import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/tutor.dart';

// Future<DocumentSnapshot> getUserRole(String user_id) async {
//   DocumentReference docRef =
//       FirebaseFirestore.instance.collection('users').doc(user_id);
//   DocumentSnapshot docSnapshot = await docRef.get();
//   print(docSnapshot['role']);

//   return docSnapshot['role'];
// }
// Future<DocumentSnapshot> getUserPhone(String user_id) async {
//   DocumentReference docRef =
//       FirebaseFirestore.instance.collection('users').doc(user_id);
//   DocumentSnapshot docSnapshot = await docRef.get();
//   print(docSnapshot['phone']);

//   return docSnapshot['phone'];
// }

// Future<DocumentSnapshot> getUserSnapShot(String user_id) async {
//   DocumentReference docRef =
//       FirebaseFirestore.instance.collection('users').doc(user_id);
//   DocumentSnapshot docSnapshot = await docRef.get();
//   print(docSnapshot['role']);

//   return docSnapshot;
// }

 Future<DocumentSnapshot> getUserData(String uid) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    return userRef.get();
  }

  Future<String> getDeviceToken( String uuid ) async{

    
     DocumentReference documentReference =   FirebaseFirestore.instance.collection('users').doc(uuid);
     var meso = await documentReference.get();
     String khwaja = meso['token'];

     return khwaja;


  }

  Stream<QuerySnapshot> getTutorsDataBasedOnSubject(String subject) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'tutor')
      .where('subject',isEqualTo: subject)
      .snapshots();
}

Tutor initalizeTutorModel(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  return Tutor(
    id: data['tutor_id'] ?? '',
    email: data['email'] ?? '',
    experience: data['experience'] ?? '',
    hourly_rate: data['hourly_rate'] ?? '',
    location: data['location'] ?? '',
    name: data['name'] ?? '',
    phone: data['phone'] ?? '',
    profile_pic: data['profile_picture'] ?? '',
    qualification: data['qualification'] ?? '',
    role: data['role'] ?? '',
    token: data['token']?? '',
    subject: data['subject'] ?? '',
  );
}
