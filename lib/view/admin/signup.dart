// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Model/register.dart';
import '../../Model/usermodel.dart';
import '../../controller/constants.dart';
import '../../controller/mybutton.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../dashboard.dart';
import 'login.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  final RegisterViewModel _registerVM = RegisterViewModel();
  String errMsg = "";

  DateTime? _selectedDate;

  bool _isSigningUp = false;
  bool isRegistered = false;

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return "null";
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return "null";
  }

  String _validatename(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length < 3) {
      return 'Name should be valid';
    }
    return "null";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _mobilecontroller.dispose();
    _id.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/anim/user.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: _emailController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        prefixIcon: Icon(CupertinoIcons.mail_solid,
                            color: Colors.black),
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'Email '),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your date of birth.';
                      }
                      // Add additional date format validation if needed
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: _name,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        prefixIcon: Icon(CupertinoIcons.person_alt_circle_fill,
                            color: Colors.black),
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'Full Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your date of birth.';
                      }
                      // Add additional date format validation if needed
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: _mobilecontroller,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        prefixIcon:
                            Icon(CupertinoIcons.phone, color: Colors.black),
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'Phone '),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: _id,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        prefixIcon: Icon(Icons.wallet, color: Colors.black),
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'ID No:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid id';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: _passController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'Password:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid id';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[100]),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.calendar,
                                color: Colors.black),
                          ),
                          Text(
                            _selectedDate == null
                                ? 'Select DOB'
                                : '${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ).pSymmetric(v: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: _isSigningUp
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              if (_selectedDate == null) {
                                _showSnackbar(
                                    'Please select your date of birth');
                                return;
                              }
                              int age =
                                  DateTime.now().year - _selectedDate!.year;
                              if (age < 18) {
                                _showSnackbar(
                                    'You must be at least 18 years old to sign up');
                                return;
                              }

                              setState(() {
                                _isSigningUp = true;
                              });
                              // call Firebase function to sign up user
                              bool isRegistered = false;
                              isRegistered = await _registerVM.register(
                                  _mobilecontroller.text.trim(),
                                  _emailController.text.trim(),
                                  _passController.text.trim(),
                                  _name.text.trim(),
                                  _id.text.trim());
                              if (isRegistered) {
                                var userId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                await FirebaseFirestore.instance
                                    .collection("Admin")
                                    .doc(userId)
                                    .set({
                                  "First Name": _name.text.trim(),
                                  "Personal ID": _id.text.trim(),
                                  "Email": _emailController.text.trim(),
                                  "Phone": _mobilecontroller.text.trim(),
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => DashBoard()),
                                    (Route<dynamic> route) => false);
                              } else {
                                setState(() {
                                  _isSigningUp = false;
                                  errMsg = _registerVM.message;
                                });
                              }
                            }
                          },
                    child: Container(
                      height: height / 15,
                      width: width - 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: grad3.withOpacity(0.0), // Shadow color
                            spreadRadius: 0, // Spread radius
                            blurRadius: 0, // Blur radius
                            offset: Offset(
                                0, 0), // Offset in the x and y directions
                          ),
                        ],

                        color: grad3,
                        borderRadius: BorderRadius.circular(
                            10.0), // Customize border radius
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                              colors: [black, Colors.indigo.shade900]),
                          width: 2,
                        ),
                      ),
                      child: _isSigningUp
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Colors.black, // Customize button text color
                              ),
                            ).centered(),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => Login()));
                      },
                      child: Text("Signin to Your Id"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
