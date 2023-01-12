import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:project_quizz/screens/onboarding/loadpage_welcome.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final Color color1 = const Color(0xFFCF3530);
  final Color color2 = const Color(0xFFE1372F);
  final Color color3 = const Color(0xFFFF6C1C);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF09031D),
      body: OpenContainer(
          closedBuilder: (_, OpenContainer) {
            return SizedBox(
              height: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 350,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 200,
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
                    top: 350,
                    left: 0,
                    right: 150,
                    bottom: 80,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: color1,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: size.height / 2,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 40.0),
                          AnimatedTextKit(
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              WavyAnimatedText(
                                'WELCOME BACK!',
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Chào mừng bạn đến với Game Quiz',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 22.0),
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          const Align(
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
                          const Spacer(),
                          AnimatedTextKit(
                            pause: const Duration(milliseconds: 500),
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              FadeAnimatedText(
                                'Nhấn bất kỳ đâu để tiếp tục',
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 380,
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.black38, blurRadius: 30.0)
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
          },
          openColor: Colors.red,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          openBuilder: (_, closeContainer) {
            return LoadPageWelcome();
          }),
    );
  }
}
