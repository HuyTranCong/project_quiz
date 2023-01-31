import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/screens/home/home.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  final Color color1 = Color(0xFFCF3530);
  final Color color2 = Color(0xFFE1372F);
  final Color color3 = Color(0xFFFF6C1C);

  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                context,
                AnimatingRoute(
                  route: HomeScreen(),
                ),
              );
              Timer(Duration(milliseconds: 500), () {
                scaleController.reset();
              });
            }
          });
    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(scaleController);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: size.height / 3,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              // height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color2, color3],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: size.width / 2,
            bottom: size.height / 4,
            child: Container(
              decoration: BoxDecoration(
                color: color1,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50.0),
                ),
              ),
            ),
          ),

          //button get started
          Positioned(
            top: size.height / 2,
            left: 0,
            right: 0,
            child: Container(
              height: size.height / 2, //380
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  AnimatedTextKit(
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      WavyAnimatedText(
                        'WELCOME BACK!',
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Chào mừng bạn đến với Game Quiz',
                      style: TextStyle(color: Colors.white70, fontSize: 22.0),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Game giúp bạn giải trí giảm bớt căng thẳng trong cuộc sống hằng ngày',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),

                  //button get started
                  InkWell(
                    onTap: () {
                      scaleController.forward();
                    },
                    child: Stack(
                      children: [
                        Container(
                            width: 200,
                            height: 60,
                            decoration: BoxDecoration(
                              // color: Colors.red.withOpacity(.5),
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: AnimatedBuilder(
                              animation: scaleAnimation,
                              builder: (context, child) => Transform.scale(
                                scale: scaleAnimation.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1B1E44),
                                  ),
                                ),
                              ),
                            )),
                        Positioned.fill(
                          child: Center(
                            child: AnimatedTextKit(
                              pause: Duration(milliseconds: 500),
                              repeatForever: true,
                              isRepeatingAnimation: true,
                              animatedTexts: [
                                FadeAnimatedText('GET STARTED!',
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: size.height / 2, //380
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.redAccent.withOpacity(.2), blurRadius: 50.0)
            ]),
            child: SizedBox(
              height: 350,
              width: size.width,
              child: Image.asset(
                'assets/images/image_3.gif',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatingRoute extends PageRouteBuilder {
  var page;
  var route;

  AnimatingRoute({this.page, this.route})
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
