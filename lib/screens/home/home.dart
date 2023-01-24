import 'dart:async';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_quizz/components/menu.dart';
import 'package:project_quizz/screens/home/rank.dart';
import 'package:project_quizz/screens/home/singleplayer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final fabKey = GlobalKey<FabCircularMenuState>();

  bool isTapped = false;

  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  int exp = 1;

  // getId
  Future getId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              final r = document.data() as Map<String, dynamic>;
              try {
                setState(() {
                  name = r['username'];
                  exp = r['exp'];
                });
              } catch (e) {
                print(e.toString());
              }
            }));
  }

  //Disable Back Button
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App?'),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  }),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    getId();
    Size size = MediaQuery.of(context).size;

    //===================================
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF09031D),
              Color(0xFF1B1E44),
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
          //menu
          floatingActionButton: Builder(
            builder: (context) => Menu(fabKey: fabKey),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //username + time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Xin Chào ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          Text('$name',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          DateFormat('hh:mm:ss a').format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                //image
                Image.asset(
                  'assets/images/avatar.png',
                  width: size.width / 2,
                  height: size.width / 2,
                  fit: BoxFit.cover,
                ),

                //playgame
                //choidon
                AnimatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SinglePlayerScreen(),
                    ));
                  },
                  child: const Text(
                    'Chơi Đơn',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                //choixephang
                AnimatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RankScreen(),
                    ));
                  },
                  child: const Text(
                    'Chơi Xếp Hạng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //lichsu
                AnimatedButton(
                  color: Colors.orange,
                  onPressed: () {},
                  child: const Text(
                    'Lịch sử chơi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //bxh
                AnimatedButton(
                  color: Colors.orange,
                  onPressed: () {},
                  child: const Text(
                    'Bảng xếp hạng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //thoat
                AnimatedButton(
                  width: size.width / 4,
                  color: Colors.red,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('Do you want to Exit Game?'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                if (Platform.isAndroid) {
                                  SystemNavigator.pop();
                                } else {
                                  exit(0);
                                }
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.red,
                                ),
                              ),
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Thoát',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
