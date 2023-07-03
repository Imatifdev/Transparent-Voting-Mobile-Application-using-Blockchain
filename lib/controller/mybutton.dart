// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import 'constants.dart';

class GradientBorderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  GradientBorderButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 15,
      width: width - 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: grad3.withOpacity(0.0), // Shadow color
            spreadRadius: 0, // Spread radius
            blurRadius: 0, // Blur radius
            offset: Offset(0, 0), // Offset in the x and y directions
          ),
        ],

        color: grad3,
        borderRadius: BorderRadius.circular(10.0), // Customize border radius
        border: GradientBoxBorder(
          gradient: LinearGradient(colors: [black, Colors.indigo.shade900]),
          width: 2,
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black, // Customize button text color
          ),
        ),
      ),
    );
  }
}
