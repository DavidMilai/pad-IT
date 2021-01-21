import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class DatabaseService {
  final String userEmail;
  DatabaseService({this.userEmail});
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('Schools');

  final CollectionReference donorCollection =
      FirebaseFirestore.instance.collection('Schools');

  Future addDonor(String donations, String organization, String photo) async {
    return await donorCollection.doc(kDBtoUse).collection('sponsors').add(
        {"donations": donations, "organization": organization, "photo": photo});
  }

  Future addStudent(
      String name,
      String age,
      String studentClass,
      String studentNumber,
      String phoneNumber,
      String status,
      String photo) async {
    return await studentsCollection.doc(kDBtoUse).collection('students').add({
      "age": age,
      "class": studentClass,
      "name": name,
      "number": studentNumber,
      "phoneNumber": phoneNumber,
      "photo": photo,
      "status": status
    });
  }
}
