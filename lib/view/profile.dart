// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testsy/controller/constants.dart';
import 'package:velocity_x/velocity_x.dart';

import 'admin/login.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  int check = 0;
  String name = "name1";
  String email = "example@gmail.com";
  String phone = 'loading...';
  String id = 'loading...';

  void getInfo() async {
    var collection = FirebaseFirestore.instance.collection('Admin');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        email = data?["Email"];
        phone = data?["Phone"];
        id = data?["Personal ID"];
      });
    }
    print(name);
    print(id);
    print(phone);
    print(userId);
  }

  void _signOutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
    } catch (e) {
      // Handle sign-out errors here, if any.
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey)),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.person_alt_circle,
                size: 40,
                color: grad2,
              ),
              title: Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey)),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.info_circle,
                size: 40,
                color: grad2,
              ),
              title: Text(
                id,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey)),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.phone,
                size: 40,
                color: grad2,
              ),
              title: Text(
                phone,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey)),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.mail_solid,
                size: 40,
                color: grad2,
              ),
              title: Text(
                email,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: grad3),
              onPressed: () {
                _signOutUser(context);
              },
              icon: Icon(Icons.logout_sharp, color: Colors.black),
              label: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ).p(20),
    );
  }
}
