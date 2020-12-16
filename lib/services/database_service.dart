import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userEmail;
  DatabaseService({this.userEmail});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future setUserData(
      String email, String firstName, String lastName, var phoneNumber) async {
    return await userCollection.doc(userEmail).collection('details').doc().set({
      "Email": email,
      "First Name": firstName,
      "Last Name": lastName,
      "Phone Number": phoneNumber,
    });
  }
}
