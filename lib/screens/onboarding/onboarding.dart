import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:project_quizz/screens/onboarding/loadpage_welcome.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF00004D).withOpacity(.9),
      body: OpenContainer(
          closedBuilder: (_, OpenContainer) {
            return Column(
              children: [
                //image1
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage('assets/images/13.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          const Color(0xFF1B1E44).withOpacity(.8),
                          const Color(0xFF2D3447).withOpacity(.2),
                        ])),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'WELCOME BACK!...',
                              speed: Duration(milliseconds: 150),
                              textStyle: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 5),
                            )
                          ],
                          isRepeatingAnimation: true,
                          repeatForever: true,
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ),
                    ),
                  ),
                ),

                //image2
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1B1E44).withOpacity(.8),
                          const Color(0xFF2D3447).withOpacity(.2),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          const Color(0xFF1B1E44).withOpacity(.8),
                          const Color(0xFF2D3447).withOpacity(.2),
                        ])),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText(
                                'Game giúp bạn giải trí Giảm bớt căng thẳng trong cuộc sống!',
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    wordSpacing: 1),
                                speed: Duration(milliseconds: 150)),
                          ],
                          isRepeatingAnimation: true,
                          repeatForever: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          openColor: Colors.red,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          openBuilder: (_, closeContainer) {
            return LoadPageWelcome();
          }),
    );
  }
}
