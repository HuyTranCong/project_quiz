import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/screens/page_welcome.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OpenContainer(
          closedBuilder: (_, OpenContainer) {
            return Center(child: Text('Chào mừng bạn!'));
          },
          openColor: Colors.white,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          transitionDuration: Duration(milliseconds: 700),
          openBuilder: (_, closeContainer) {
            return PageWelcome();
          },
        ),
      ),
    );
  }
}
