// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:testsy/controller/constants.dart';
import 'package:testsy/view/profile.dart';
import 'package:testsy/view/searchusers.dart';
import 'package:testsy/view/settingsscreen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin/usersignup.dart';
import 'forgotpass.dart';
import 'home.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }

    // final controller = Get.put(ProfileController());
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LottieBuilder.asset(
                "assets/anim/userprofile.json",
                height: 200,
                fit: BoxFit.cover,
              ).centered(),
              Text(
                "Hello \u{1F44B}",
                style: TextStyle(
                    fontSize: 50, color: grad3, fontWeight: FontWeight.bold),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Divider(
                color: grad2,
                thickness: .5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => InstructionsScreen()));
                },
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [grad3, grad2, grad1],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/vote.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Start New",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Election",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => ProfileView()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [grad3, grad2, grad1],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                              "assets/anim/profile.json",
                              height: 70,
                              width: 50,
                              fit: BoxFit.cover,
                            ).pOnly(right: 20),
                            Text(
                              "Profile",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => SettingsScreen()));
                    },
                    child: Expanded(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [grad3, grad2, grad1],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                              "assets/anim/seetings.json",
                              height: 70,
                              width: 50,
                              fit: BoxFit.cover,
                            ).pOnly(right: 20),
                            Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => UserCreate()));
                },
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [grad3, grad2, grad1],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/user.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Register New",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Voter",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "About Transparent Voting",
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: grad3),
              ),
              Divider(
                color: grad2,
                thickness: .5,
              ).pOnly(right: 60),
              SizedBox(
                height: 10,
              ),
              Text(
                "A secure voting app is a digital platform designed to ensure the integrity and confidentiality of the voting process, providing a trusted and convenient way for individuals to cast their votes remotely.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ).pSymmetric(h: 30, v: 20),
        ),
      ),
    );
  }
}
