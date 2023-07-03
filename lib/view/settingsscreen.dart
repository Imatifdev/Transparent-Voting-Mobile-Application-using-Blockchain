// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testsy/view/searchusers.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Settings",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.brightness_2_outlined),
            title: Text("Theme"),
            trailing: Icon(CupertinoIcons.right_chevron),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => SearchScreen()));
            },
            leading: Icon(Icons.search),
            title: Text("Search Voters"),
            trailing: Icon(CupertinoIcons.right_chevron),
          ),
          Divider(),
        ],
      ).p(20),
    );
  }
}
