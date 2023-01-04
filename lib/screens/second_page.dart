import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/screens/home.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _a = true;
        });
      }
    });

    Timer(Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _b = true;
        });
      }
    });

    Timer(Duration(milliseconds: 1300), () {
      if (mounted) {
        setState(() {
          _c = true;
        });
      }
    });

    Timer(Duration(milliseconds: 1700), () {
      if (mounted) {
        setState(() {
          _e = true;
        });
      }
    });

    Timer(Duration(milliseconds: 3400), () {
      if (mounted) {
        setState(() {
          _d = true;
        });
      }
    });

    Timer(Duration(milliseconds: 3850), () {
      if (mounted) {
        setState(() {
          Navigator.of(context).pushReplacement(
            ThisIsFadeRoute(
              route: HomeScreen(),
              page: HomeScreen(),
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _a = false;
    _b = false;
    _c = false;
    _d = false;
    _e = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? _height / 2
                      : 20,
              width: 20,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                          ? 2
                          : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _height
                  : _c
                      ? 200
                      : 20,
              decoration: BoxDecoration(
                  color: _b ? Colors.white : Colors.transparent,
                  borderRadius: _d
                      ? const BorderRadius.only()
                      : BorderRadius.circular(30)),
              child: Center(
                child: _e
                    ? AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          FadeAnimatedText(
                            'CBSCDY',
                            duration: const Duration(milliseconds: 1000),
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({required this.page, required this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}
