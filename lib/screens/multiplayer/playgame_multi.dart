import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:project_quizz/components/answer_tile.dart';
import 'package:project_quizz/models/question.dart';
import 'package:project_quizz/screens/multiplayer/result_multi.dart';

class BattleScreen extends StatefulWidget {
  BattleScreen(
      {super.key,
      required this.totalTime,
      required this.questions,
      required this.counter});
  final int totalTime;
  final List<Question> questions;
  final int counter;
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int _currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  String _selectedAnswer = '';
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(_currentTime);
      if (mounted)
        setState(() {
          _currentTime -= 1;
        });
      if (_currentTime == 0) {
        _timer.cancel();

        pushResultScreen(context);
      }
    });
  }

  void runtimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(_currentTime);
      if (mounted)
        setState(() {
          _currentTime -= 1;
        });
      if (_currentTime == 0) {
        _timer.cancel();

        pushResultScreen(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final currentQuestion = widget.questions[_currentIndex];

    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //time
                Container(
                  height: 30.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        LinearProgressIndicator(
                          value: _currentTime / widget.totalTime,
                          color: _timer.tick >= _currentTime * 3.5
                              ? Colors.red
                              : _timer.tick >= _currentTime * 1
                                  ? Colors.yellowAccent
                                  : Colors.green,
                        ),
                        Center(
                          child: Text(
                            _currentTime.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //question + answers
                Container(
                  width: size.width,
                  height: size.height / 1.2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'CÂU HỎI:',
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      //cauhoi
                      Container(
                        width: size.width,
                        height: size.width / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: GradientColors.indigo,
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentQuestion.question,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                      //dapan
                      Expanded(
                        child: ListView.builder(
                          itemCount: currentQuestion.answers.length,
                          itemBuilder: (context, index) {
                            final answer = currentQuestion.answers[index];
                            return AnswerTile(
                              isSelected: answer == _selectedAnswer,
                              answer: answer,
                              correctAnswer: currentQuestion.correctAnswer,
                              onTap: () {
                                setState(() {
                                  _selectedAnswer = answer;
                                });
                                if (answer == currentQuestion.correctAnswer) {
                                  _score += 10;
                                }
                                Future.delayed(Duration(milliseconds: 200),
                                    (() {
                                  if (_currentIndex ==
                                          widget.questions.length - 1 ||
                                      _currentTime == 0) {
                                    pushResultScreen(context);
                                    return;
                                  }
                                  setState(() {
                                    _currentIndex++;
                                    _selectedAnswer = '';
                                  });
                                }));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultMultiScreen(
          result: _score,
        ),
      ),
    );
  }
}
