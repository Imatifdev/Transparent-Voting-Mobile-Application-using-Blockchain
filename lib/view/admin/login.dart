// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:testsy/controller/constants.dart';
import 'package:testsy/view/dashboard.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Model/signin.dart';
import '../../controller/mybutton.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController _id = TextEditingController();
  bool _isLoggingIn = false;

  final LoginViewModel _loginVM = LoginViewModel();

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

  @override
  Widget build(BuildContext context) {
    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Perform login or further actions
        String _email = email.text;
        String password = pass.text;

        // Process the login credentials

        print('Email: $_email');
        print('Password: $password');
      }
    }

    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login ID",
                  style: TextStyle(fontSize: 60),
                ),
                Text(
                  "Welcome Admin!",
                  style: TextStyle(fontSize: 40, color: grad2),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: email,
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
                      hintText: 'Email'),
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
                InkWell(
                  splashColor: Colors.white,
                  onTap: _isLoggingIn
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoggingIn = true;
                            });
                            bool isLoggedIn =
                                await _loginVM.login(email.text, _id.text);
                            setState(() {
                              _isLoggingIn = false;
                            });
                            if (!isLoggedIn) {
                              Fluttertoast.showToast(
                                msg: 'Invalid email or password',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => DashBoard()),
                                  (Route<dynamic> route) => false);
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
                          offset:
                              Offset(0, 0), // Offset in the x and y directions
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
                    child: _isLoggingIn
                        ? CircularProgressIndicator().centered()
                        : Text(
                            'Sign In',
                            style: TextStyle(color: Colors.black),
                          ).centered(),
                  ),
                ).centered()
              ],
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
}
