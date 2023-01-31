import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:project_quizz/components/answer_tile.dart';
import 'package:project_quizz/models/question.dart';
import 'package:project_quizz/screens/home/home.dart';
import 'package:project_quizz/screens/singleplayer/result.dart';

class PlayGameScreen extends StatefulWidget {
  PlayGameScreen({
    Key? key,
    required this.totalTime,
    required this.questions,
  }) : super(key: key);
  final int totalTime;
  final List<Question> questions;
  @override
  State<PlayGameScreen> createState() => _PlayGameScreenState();
}

class _PlayGameScreenState extends State<PlayGameScreen> {
  late int currentTime;
  late Timer timer;

  int _currentIndex = 0;
  int _score = 0;
  String _selectedAnswer = '';

  bool isHelp = true;
  bool isCall = true;

  @override
  void initState() {
    super.initState();

    //
    currentTime = widget.totalTime;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(currentTime);
      if (mounted)
        setState(() {
          currentTime -= 1;
        });
      if (currentTime == 0) {
        timer.cancel();

        pushResultScreen(context);
      }
    });
  }

  @override
  void runtimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(currentTime);
      if (mounted)
        setState(() {
          currentTime -= 1;
        });
      if (currentTime == 0) {
        timer.cancel();

        pushResultScreen(context);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
            score: _score,
            questions: widget.questions,
            totalTime: widget.totalTime),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final currentQuestion = widget.questions[_currentIndex];

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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                          value: currentTime / widget.totalTime,
                          color: timer.tick >= currentTime * 3.5
                              ? Colors.redAccent
                              : timer.tick >= currentTime * 1
                                  ? Colors.yellow
                                  : Colors.green,
                        ),
                        Center(
                          child: Text(
                            currentTime.toString(),
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
                                      widget.questions.length - 1) {
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

                //support
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //call
                    isCall
                        ? ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.purple),
                            ),
                            onPressed: () async {
                              timer.cancel();
                              isCall = false;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Trợ Giúp Gọi Điện Thoại!'),
                                    content: Text(currentQuestion.correctAnswer
                                        .toString()),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          runtimer();
                                        },
                                        child: Text('Cám Ơn!'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.account_box_outlined),
                            label: Text('CALL'),
                          )
                        : Text(''),

                    //50-50
                    isHelp
                        ? ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.deepPurple),
                            ),
                            onPressed: () async {
                              final ls = [];
                              currentQuestion.answers.forEach((element) {
                                if (element != currentQuestion.correctAnswer &&
                                    ls.length < 2) {
                                  ls.add(element);
                                }
                              });
                              isHelp = false;
                              timer.cancel();
                              return showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Trợ Giúp 50 : 50'),
                                    content: SizedBox(
                                      height: size.height / 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Loại đáp án: ' + ls[0]),
                                          Text('Loại đáp án: ' + ls[1]),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          runtimer();
                                        },
                                        child: Text('Cám Ơn!'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.help_outline),
                            label: Text('50-50'),
                          )
                        : Text(''),

                    //stop
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.red),
                      ),
                      onPressed: () {
                        timer.cancel();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Tạm Dừng'),
                              content: Text('Bạn có muốn tiếp tục chơi không?'),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.red,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()),
                                                (route) => false);
                                      },
                                      child: Text('Về Trang Chủ'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        runtimer();
                                      },
                                      child: Text('Có'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.stop_circle_outlined),
                      label: Text('STOP'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
