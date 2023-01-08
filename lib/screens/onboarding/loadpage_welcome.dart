import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:project_quizz/screens/home/home.dart';

class LoadPageWelcome extends StatefulWidget {
  const LoadPageWelcome({super.key});

  @override
  State<LoadPageWelcome> createState() => _LoadPageWelcomeState();
}

class _LoadPageWelcomeState extends State<LoadPageWelcome> {
  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //400
    Timer(Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _a = true;
        });
      }
    });

    //400
    Timer(Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _b = true;
        });
      }
    });

    //1300
    Timer(Duration(milliseconds: 1300), () {
      if (mounted) {
        setState(() {
          _c = true;
        });
      }
    });

    //1700
    Timer(Duration(milliseconds: 1700), () {
      if (mounted) {
        setState(() {
          _e = true;
        });
      }
    });

    //3400
    Timer(Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _d = true;
        });
      }
    });

    //3850
    Timer(Duration(milliseconds: 3500), () {
      if (mounted) {
        setState(() {
          Navigator.of(context).pushReplacement(
            ThisIsFadeRoute(route: HomeScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
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
      backgroundColor: const Color(0xFF09031D),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              //900 : 2500
              duration: Duration(milliseconds: _d ? 800 : 2000),
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
                      ? 80
                      : 20,
              width: _d
                  ? _width
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
                            'Ô VĂN KÊ',
                            //1700
                            duration: const Duration(milliseconds: 1700),
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF09031D),
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
  var page;
  var route;

  ThisIsFadeRoute({this.page, this.route})
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
