import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/models/question.dart';
import 'package:project_quizz/screens/singleplayer/playgame.dart';

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({Key? key, required this.topic}) : super(key: key);

  final int topic;

  @override
  State<DifficultyScreen> createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text('Chọn Độ Khó',
              style: TextStyle(color: Color(0xFFA9DED8), fontSize: 30)),
          iconTheme: const IconThemeData(color: Colors.blue),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            height: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //de
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('questions')
                      .where('topicId', isEqualTo: widget.topic)
                      .where('difficultId', isEqualTo: 1)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final questionDocs = snapshot.data!.docs;
                    final questions = questionDocs
                        .map((e) => Question.fromQueryDocumentSnapshot(e))
                        .toList();
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('config')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final configDoc = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;
                        final totalTime = configDoc['key'];
                        return Column(
                          children: [
                            AnimatedButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PlayGameScreen(
                                      totalTime: totalTime,
                                      questions: questions,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Dễ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text('Tổng câu hỏi: ${questions.length}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        );
                      },
                    );
                  },
                ),

                //thuong
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('questions')
                      .where('topicId', isEqualTo: widget.topic)
                      .where('difficultId', isEqualTo: 2)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final questionDocs = snapshot.data!.docs;
                    final questions = questionDocs
                        .map((e) => Question.fromQueryDocumentSnapshot(e))
                        .toList();
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('config')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final configDoc = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;
                        final totalTime = configDoc['key'];
                        return Column(
                          children: [
                            AnimatedButton(
                              color: Colors.orange,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PlayGameScreen(
                                      totalTime: totalTime,
                                      questions: questions,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Thường',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text('Tổng câu hỏi: ${questions.length}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        );
                      },
                    );
                  },
                ),

                //kho
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('questions')
                      .where('topicId', isEqualTo: widget.topic)
                      .where('difficultId', isEqualTo: 3)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final questionDocs = snapshot.data!.docs;
                    final questions = questionDocs
                        .map((e) => Question.fromQueryDocumentSnapshot(e))
                        .toList();
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('config')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final configDoc = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;
                        final totalTime = configDoc['key'];
                        return Column(
                          children: [
                            AnimatedButton(
                              color: Colors.red,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PlayGameScreen(
                                      totalTime: totalTime,
                                      questions: questions,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Khó',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text('Tổng câu hỏi: ${questions.length}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
