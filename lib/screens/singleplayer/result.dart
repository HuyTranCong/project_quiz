import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/models/question.dart';
import 'package:project_quizz/screens/home/home.dart';
import 'package:project_quizz/screens/singleplayer/playgame.dart';
import 'package:project_quizz/screens/singleplayer/singleplayer.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen(
      {super.key,
      required this.score,
      required this.questions,
      required this.totalTime});
  final int score;
  final List<Question> questions;
  final int totalTime;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Future _updateHightScore() async {
    final AuthUser = FirebaseAuth.instance.currentUser;

    if (AuthUser == null) return;

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(AuthUser.uid);

    final userDoc = await userRef.get();
    if (userDoc.exists) {
      final user = userDoc.data();
      if (user == null) return;

      final lastHighScore = user['score'];
      var result = widget.score;
      result = lastHighScore >= widget.score ? lastHighScore : widget.score;

      userRef.update({
        'score': result,
        'date': Timestamp.now(),
        'exp': user['exp'] +
            (widget.score >= widget.questions.length / 2 * 10 ? 10 : 5),
      });

      return;
    }
  }

  Future _history() async {
    final AuthUser = FirebaseAuth.instance.currentUser;

    if (AuthUser == null) return;

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(AuthUser.uid);
    final userDoc = await userRef.get();

    final user = userDoc.data();
    var username = user!['username'];
    FirebaseFirestore.instance.collection('history').add({
      'date': Timestamp.now(),
      'username': username,
      'email': AuthUser.email,
      'score': widget.score,
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _updateHightScore();
    _history();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Xin Chúc Mừng Bạn Đã Đạt Được:',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 20.0),
              Text(
                '${widget.score} ĐIỂM',
                style: TextStyle(color: Colors.yellow, fontSize: 50),
              ),
              Spacer(),

              //button
              AnimatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlayGameScreen(
                      totalTime: widget.totalTime,
                      questions: widget.questions,
                    ),
                  ));
                },
                child: Text('Chơi lại', style: TextStyle(fontSize: 20)),
              ),

              SizedBox(height: 20.0),

              AnimatedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SinglePlayerScreen(),
                  ));
                },
                child: Text('Chủ Đề Khác',
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
