import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/screens/home/home.dart';
import 'package:project_quizz/screens/multiplayer/multiplayer_wait.dart';

class ResultMultiScreen extends StatefulWidget {
  ResultMultiScreen({super.key, required this.result});
  final int result;
  @override
  State<ResultMultiScreen> createState() => _ResultMultiScreenState();
}

class _ResultMultiScreenState extends State<ResultMultiScreen> {
  @override
  Widget build(BuildContext context) {
    getMatch();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF09031D),
                  Color(0xFF1B1E44),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              //
              Stack(
                children: [
                  Image.asset(
                    'assets/gif/congratulations.gif',
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        'KẾT THÚC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: result1 > result2
                    ? Image.asset(
                        'assets/gif/win.gif',
                        width: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.cover,
                      )
                    : result1 < result2
                        ? Image.asset(
                            'assets/gif/lose.gif',
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/gif/tie.gif',
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover,
                          ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$result1 - $result2',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.red),
                ),
              ),
              SizedBox(height: 20.0),

              //button
              AnimatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MultiplayerScreen(),
                  ));
                },
                child: Text('Chơi Tiếp',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              AnimatedButton(
                color: Colors.brown,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
                },
                child: Text('Trang Chủ',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  Future getUser() async {
    await firestore.collection('users').doc(auth.uid).get().then((value) {
      setState(() {});
    });
  }

  Future update() async {
    int match = 0;

    await firestore.collection('counters').doc('wait').get().then((value) {
      match = value.get('counter') - 2;
    });
    final doc = firestore.collection('match').doc(match.toString());
    doc.get().then((value) {
      if (auth.uid == value.get('user1')[0]) {
        var ls = value.get('user1');
        ls[2] = widget.result;
        doc.update({'user1': ls});
      } else {
        var ls = value.get('user2');
        ls[2] = widget.result;
        doc.update({'user2': ls});
      }
    });
  }

  String uid1 = '';
  String uid2 = '';
  int result1 = 0;
  int result2 = 0;
  bool? isUp;

  Future getMatch() async {
    int match = 0;

    await firestore.collection('counters').doc('wait').get().then((value) {
      if (value.get('counter') % 2 == 0) {
        match = value.get('counter') - 2;
        firestore.collection('match').doc(match.toString()).get().then((value) {
          uid1 = auth.uid;
          if (uid1 == value.get('user1')[0]) {
            if (mounted) {
              setState(() {
                uid2 = value.get('user2')[0];
                result1 = value.get('user1')[2];
                result2 = value.get('user2')[2];
              });
            }
          } else if (uid1 == value.get('user2')[0]) {
            if (mounted) {
              setState(() {
                uid2 = value.get('user1')[0];
                result1 = value.get('user2')[2];
                result2 = value.get('user1')[2];
              });
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUser().then((value) => setState(() {}));
    update().then((value) => setState(() {}));
  }
}
