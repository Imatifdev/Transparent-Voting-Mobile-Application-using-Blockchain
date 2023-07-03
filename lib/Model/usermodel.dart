import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String personalid;
  final String pass;
  final String phone;
  final String email;
  const UserModel(
      {this.id,
      required this.email,
      required this.name,
      required this.personalid,
      required this.pass,
      required this.phone});

  toJson() {
    return {
      'First Name': name,
      'ID ': personalid,
      'Email': email,
      'Password': pass,
      'Phone': phone,
    };
  }

  //map for fecthing users from firestore
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data['Email'],
        personalid: data['Personal id'],
        name: data['First Name'],
        pass: data['Pass'],
        phone: data['Phone']);
  }
}
