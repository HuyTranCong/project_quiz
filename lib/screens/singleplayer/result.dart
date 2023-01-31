import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/models/question.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen(
      {super.key,
      required this.score,
      required this.questions,
      required this.totalTime});
  final int score;
  final List<Question> questions;
  final int totalTime;

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
                '$score ĐIỂM',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              Spacer(),
              //button
              AnimatedButton(
                onPressed: () {},
                child: Text('Chơi lại', style: TextStyle(fontSize: 20)),
              ),

              SizedBox(height: 20.0),

              AnimatedButton(
                onPressed: () {},
                child: Text('Về Trang Chủ', style: TextStyle(fontSize: 20)),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
