import 'package:firebase_database/firebase_database.dart';

class User {
  String fullName;
  String email;
  String phone;
  String uid;

  User({this.fullName, this.email, this.phone, this.uid});

  User.fromSnapshot(DataSnapshot snapshot) {
    uid = snapshot.key;
    phone = snapshot.value["phone"];
    email = snapshot.value["email"];
    fullName = snapshot.value["fullName"];
  }
}