import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/components/action_button.dart';
import 'package:project_quizz/models/question.dart';
import 'package:project_quizz/screens/multiplayer/playgame_multi.dart';

class MultiplayerScreen extends StatefulWidget {
  MultiplayerScreen({super.key});

  @override
  State<MultiplayerScreen> createState() => _MultiplayerScreenState();
}

class _MultiplayerScreenState extends State<MultiplayerScreen> {
  final auth = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  List<Question> lsQuestion = [];
  int count = 0;

  int time = 0;
  bool isHas = false;
  late Timer timer;
  void runTime() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (mounted) {
        setState(() {
          time++;
        });
        await getMatch();
      }
      if (isHas) {
        Navigator.pop(context);
        lengthQuestion().then((value) async {
          await firestore
              .collection('questions')
              .where('id',
                  isGreaterThanOrEqualTo: (Random().nextDouble() * 1).floor())
              .limit(90)
              .get()
              .then((value) {
            final questionDocs = value.docs;

            lsQuestion = questionDocs
                .map((e) => Question.fromQueryDocumentSnapshot(e))
                .toList();
          }).then((value) {
            FirebaseFirestore.instance
                .collection('config')
                .doc('totalBattle')
                .get()
                .then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BattleScreen(
                        counter: count,
                        questions: lsQuestion,
                        totalTime: value.get('key'),
                      ),
                    ),
                    (route) => false));
          });
        });
        timer.cancel();
      }
    });
  }

  String uid1 = '';
  String uid2 = '';
  String name1 = '';
  String name2 = '';
  int roomid = -1;

  Future getName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth!.uid)
        .get()
        .then(
      (value) {
        uid1 = auth!.uid;
        name1 = value.get('username');
      },
    );
  }

  Future getMatch() async {
    await FirebaseFirestore.instance
        .collection('match')
        .doc(roomid.toString())
        .get()
        .then((value) {
      uid1 = auth!.uid;
      if (uid1 == value.get('user1')[0]) {
        uid2 = value.get('user2')[0];
        name1 = value.get('user1')[1];
        name2 = value.get('user2')[1];
      } else if (uid1 == value.get('user2')[0]) {
        uid2 = value.get('user1')[0];
        name1 = value.get('user2')[1];
        name2 = value.get('user1')[1];
      }
    });
    if (uid2 != '') {
      setState(() {
        isHas = true;
        timer.cancel();
      });
    }
  }

  int ls = 0;
  Future lengthQuestion() async {
    // final authUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('questions')
        .get()
        .then((value) => setState(() {
              ls = value.docs.length;
            }));
  }

  @override
  void initState() {
    super.initState();
    getName().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF09031D),
            Color(0xFF1B1E44),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text('1 vs 1',
              style: TextStyle(color: Color(0xFFA9DED8), fontSize: 30)),
          iconTheme: IconThemeData(color: Colors.blue),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: size.height / 3,
                // decoration:
                //     BoxDecoration(color: Colors.white.withOpacity(0.9)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width / 3,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.blue),
                                  child: Image.asset(
                                    'assets/images/avatar1.png',
                                    fit: BoxFit.cover,
                                    height: (size.height / 3) / 2,
                                  ),
                                ),
                                Text(
                                  name1,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                )
                              ]),
                        ),
                        Container(
                          width: size.width / 3,
                          child: isHas
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                      Container(
                                        decoration:
                                            BoxDecoration(color: Colors.red),
                                        child: Image.asset(
                                          'assets/images/avatar1.png',
                                          fit: BoxFit.cover,
                                          height: (size.height / 3) / 2,
                                        ),
                                      ),
                                      Text(name2,
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red))
                                    ])
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      child: Container(
                                        height: (size.height / 3) / 2,
                                      ),
                                    ),
                                    Text('', style: TextStyle(fontSize: 20))
                                  ],
                                ),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/vs.png')
                  ],
                )),
            isHas
                ? Column(
                    children: [
                      Image.asset('assets/gif/timer.gif',
                          width: size.width / 2),
                      SizedBox(height: 10),
                    ],
                  )
                : Column(
                    children: [
                      ActionButton(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            opaque: false, // set to false
                            pageBuilder: (_, __, ___) =>
                                FutureBuilder<DocumentSnapshot>(
                              future: firestore
                                  .collection('counters')
                                  .doc('wait')
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return AlertDialog(
                                    actions: <Widget>[
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  roomid = snapshot.data!.get('counter');
                                  firestore
                                      .collection('counters')
                                      .doc('wait')
                                      .set({'counter': roomid + 1});

                                  if (roomid % 2 == 0) {
                                    firestore
                                        .collection('match')
                                        .doc((roomid).toString())
                                        .set({
                                      'user1': [
                                        auth!.uid,
                                        name1,
                                        0,
                                      ],
                                      'user2': [
                                        '',
                                        '',
                                        0,
                                      ],
                                    });
                                  } else {
                                    roomid -= 1;
                                    firestore
                                        .collection('match')
                                        .doc((roomid).toString())
                                        .update({
                                      'user2': [
                                        auth!.uid,
                                        name1,
                                        0,
                                      ],
                                    });
                                  }

                                  //loading... dang tim doi thu ko xung tam
                                  return Center(
                                    child: Container(
                                      width: size.width,
                                      height: size.height / 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/gif/loading.gif',
                                            fit: BoxFit.cover,
                                            width: size.width / 5,
                                          ),
                                          Container(
                                            alignment:
                                                AlignmentDirectional.center,
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'Đang tìm đối thủ xứng tầm.......',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              timer.cancel();
                                              if (uid2 == '') {
                                                await firestore
                                                    .collection('counters')
                                                    .doc('wait')
                                                    .get()
                                                    .then((value) => count =
                                                        value.get('counter'));
                                                await firestore
                                                    .collection('match')
                                                    .doc((count - 1).toString())
                                                    .delete();
                                                await firestore
                                                    .collection('counters')
                                                    .doc('wait')
                                                    .update(
                                                        {'counter': count - 1});
                                              }
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red)),
                                            child: Text(
                                              'Huỷ',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return AlertDialog(
                                  actions: <Widget>[
                                    Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  ],
                                );
                              },
                            ),
                          ));

                          runTime();
                        },
                        title: 'Bắt đầu',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
