// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:web3dart/web3dart.dart';

// import '../controller/constants.dart';
// import '../servicefile.dart';
// import 'electioninfo.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Client? httpClient;
//   Web3Client? ethClient;
//   TextEditingController controller = TextEditingController();

//   @override
//   void initState() {
//     httpClient = Client();
//     ethClient = Web3Client(infura_url, httpClient!);
//     super.initState();
//   }

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Start Election'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(14),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                   filled: true, hintText: 'Enter election name'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     onPressed: () async {
//                       if (controller.text.length > 0) {
//                         await startElection(controller.text, ethClient!);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ElectionInfo(
//                                     ethClient: ethClient!,
//                                     electionName: controller.text)));
//                       }
//                     },
//                     child: Text('Start Election')))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:testsy/controller/mybutton.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../controller/constants.dart';
import '../servicefile.dart';
import 'electioninfo.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final bool isAdmin;

  const Home({super.key, required this.isAdmin});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  Future<void> _openDialog(BuildContext context) async {
    String? electionName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter Election Name',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoTextField(
                  style: TextStyle(color: Colors.white),
                  controller: controller,
                  placeholderStyle: TextStyle(color: Colors.white),
                  placeholder: 'Election Name',
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text('OK'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
              isDestructiveAction: true,
            ),
          ],
        );
      },
    );

    if (electionName != null && electionName.isNotEmpty) {
      bool confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text('Confirm Election Creation'),
                content: Text('Are you sure you want to create the election?'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Yes'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                    isDestructiveAction: true,
                  ),
                ],
              );
            },
          ) ??
          false; // Use null-aware operator to assign false if confirm is null

      if (confirm) {
        await startElection(electionName, ethClient!);
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ElectionInfo(
                isAdmin: true,
                ethClient: ethClient!,
                electionName: electionName,
              ),
            ),
          );
        }
      }
    }
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  int check = 0;
  String name = "name";
  String email = "example@gmail.com";
  String phone = 'loading...';
  String id = 'loading...';

  void getInfo() async {
    var collection = FirebaseFirestore.instance.collection('UsersData');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        email = data?["Email"];
        phone = data?["Phone"];
        id = data?["ID"];
      });
    }
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/box.png',
                height: 200,
              ),
              Text(
                "Start Election",
                style: TextStyle(
                    fontSize: 35, fontWeight: FontWeight.bold, color: grad3),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Being an election admin is a powerful role, for in your hands lies the opportunity to shape the future and give voice to the people',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ).p(20),
                ).p(20),
              ),
              GradientBorderButton(
                onPressed: () {
                  _openDialog(context);
                },
                text: ('Enter Election Name'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionsScreen extends StatefulWidget {
  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
    _controller!.forward();
    _startAnimationTimer();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _timer!.cancel();
    super.dispose();
  }

  void _startAnimationTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_controller!.isCompleted) {
        _controller!.reverse();
      } else {
        _controller!.forward();
      }
    });
  }

  Future<void> _openLink() async {
    const url = 'https://www.youtube.com/'; // Replace with your desired link
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw PlatformException(
          code: 'CHANNEL_ERROR',
          message: 'Unable to open the link.',
        );
      }
    } on PlatformException catch (e) {
      print('PlatformException: ${e.message}');
      // Handle the error, display an error message, or provide an alternative action
    }
  }

  void _showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmation',
            style: TextStyle(fontSize: 30),
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Have you created your Meta Wallet and do you have enough eth coins in your wallet ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 34,
                  child: GradientBorderButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => Home(
                                      isAdmin: true,
                                    )));
                      },
                      text: "Proceed to Election"),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
            TextButton(
              onPressed: () {
                _openLink();
              },
              child: Text('Create Account'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FadeTransition(
                opacity: _fadeAnimation!,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/1.png',
                      height: 300,
                    ).centered(),
                  ],
                )),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              _openLink();
            },
            child: Text(
              'Instructions for Admin',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '1: Make sure you have created a Meta Wallet Account',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            '2: Make sure Admin have atleast 0.00005 eth in your wallet',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            '3: Make sure you every voter have atleast 0.00001 eth in their Meta Wallet',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffeee5d4)),
                onPressed: () {
                  _showDialogBox();
                },
                child: Text(
                  "Proceed to Election",
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ).pSymmetric(h: 30),
    );
  }
}
