import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testsy/controller/mybutton.dart';
import 'package:testsy/view/user/userlogin.dart';
import 'package:velocity_x/velocity_x.dart';

import 'admin/signup.dart';

class Accounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/user.png',
            height: 200,
            width: 200,
          ),
          SizedBox(
            height: 30,
          ),
          GradientBorderButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => SignupForm()));
              },
              text: ("Admin")),
          SizedBox(
            height: 20,
          ),
          GradientBorderButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => UserLogin()));
              },
              text: ("User"))
        ],
      ).centered(),
    );
  }
}
