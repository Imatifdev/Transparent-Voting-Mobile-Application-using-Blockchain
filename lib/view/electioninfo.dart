// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testsy/controller/mybutton.dart';
import 'package:web3dart/web3dart.dart';

import '../servicefile.dart';
import 'package:velocity_x/velocity_x.dart';

class ElectionInfo extends StatefulWidget {
  final bool isAdmin;

  final Web3Client ethClient;
  final String electionName;
  const ElectionInfo(
      {Key? key,
      required this.ethClient,
      required this.electionName,
      required this.isAdmin})
      : super(key: key);

  @override
  _ElectionInfoState createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController addCandidateController = TextEditingController();
  TextEditingController authorizeVoterController = TextEditingController();
  bool isButtonEnabled = true;

  void handlevoter(BuildContext context) {
    if (isButtonEnabled) {
      // Perform the desired action here
      print('Voter Address Added');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Voter Added Succesfully'),
      ));
      authorizeVoter(authorizeVoterController.text, widget.ethClient);

      // Disable the button
      isButtonEnabled = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You can not perform this action again'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Text(widget.ethClient.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              LottieBuilder.asset(
                'assets/anim/election.json',
                height: 200,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Election: ${widget.electionName}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Candidates:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FutureBuilder<List>(
                          future: getCandidatesNum(widget.ethClient),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Text(
                              snapshot.data![0].toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Votes:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FutureBuilder<List>(
                          future: getTotalVotes(widget.ethClient),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Text(
                              snapshot.data![0].toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          }),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  widget.isAdmin
                      ? TextField(
                          controller: addCandidateController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    addCandidate(addCandidateController.text,
                                        widget.ethClient);
                                  },
                                  icon: Icon(
                                    Icons.group_add_outlined,
                                    color: Colors.black,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              prefixIcon:
                                  Icon(Icons.wallet, color: Colors.black),
                              filled: true,
                              fillColor: Colors.blue[100],
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: 'Candidate Name:'),
                        )
                      : SizedBox(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 40,
                  //   child: GradientBorderButton(
                  //           onPressed: () {
                  //             addCandidate(addCandidateController.text,
                  //                 widget.ethClient);
                  //           },
                  //           text: ('Add Candidate'))
                  //       .pSymmetric(h: 120),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  TextField(
                    controller: authorizeVoterController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              handlevoter(context);
                              // authorizeVoter(authorizeVoterController.text,
                              //     widget.ethClient);
                            },
                            icon:
                                Icon(CupertinoIcons.info, color: Colors.black)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        prefixIcon: Icon(Icons.wallet, color: Colors.black),
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: 'Voter Address:'),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 40,
                  //   child: GradientBorderButton(
                  //           onPressed: () {
                  //             authorizeVoter(authorizeVoterController.text,
                  //                 widget.ethClient);
                  //           },
                  //           text: ('Add Voter'))
                  //       .pSymmetric(h: 120),
                  // )
                ],
              ),
              Divider(),
              FutureBuilder<List>(
                future: getCandidatesNum(widget.ethClient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        for (int i = 0; i < snapshot.data![0].toInt(); i++)
                          FutureBuilder<List>(
                              future: candidateInfo(i, widget.ethClient),
                              builder: (context, candidatesnapshot) {
                                if (candidatesnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return ListTile(
                                      title: Text(
                                          'Candiate: ' +
                                              candidatesnapshot.data![0][0]
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text('Votes: ' +
                                          candidatesnapshot.data![0][1]
                                              .toString()),
                                      trailing: InkWell(
                                        onTap: () {
                                          vote(i, widget.ethClient);
                                        },
                                        child: Image.asset('assets/2.png'),
                                      ));
                                }
                              })
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
