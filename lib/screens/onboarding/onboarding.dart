import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_quiz/screens/onboarding/loadpage_welcome.dart';

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
      backgroundColor: Color(0xFF09031D),
      body: OpenContainer(
          closedBuilder: (_, OpenContainer) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image_3.gif'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //icon "
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Icon(FontAwesomeIcons.quoteLeft,
                                size: 30.0, color: Color(0xFF09031D))),
                        //hockochoi...
                        Animator(
                          triggerOnInit: true,
                          curve: Curves.easeIn,
                          duration: const Duration(seconds: 1),
                          tween: Tween<double>(begin: -1, end: 0),
                          builder: (context, animatorState, child) {
                            return FractionalTranslation(
                                translation: Offset(animatorState.value, 0),
                                child: child);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF09031D).withOpacity(.5),
                                      Color(0xFF1B1E44).withOpacity(.2)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    tileMode: TileMode.clamp),
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Học tập giúp mỗi chúng ta rèn luyện bản thân hoàn thiện hơn!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),

                    //tap anywhere
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          FadeAnimatedText(
                            'Tap Anywhere To Continue!!!',
                            duration: const Duration(seconds: 5),
                            textStyle: TextStyle(
                                color: Color(0xFF09031D).withOpacity(.8),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
