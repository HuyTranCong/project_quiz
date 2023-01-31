import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_quizz/components/option_topic.dart';
import 'package:project_quizz/screens/singleplayer/select_difficulty.dart';

class SinglePlayerScreen extends StatelessWidget {
  const SinglePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Chủ Đề',
              style: TextStyle(color: Color(0xFFA9DED8), fontSize: 30)),
          iconTheme: const IconThemeData(color: Colors.blue),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Column(
                      children: [
                        Topic(
                          colors: GradientColors.nightParty,
                          title: 'Sinh Học',
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DifficultyScreen(topic: 1),
                            ));
                          },
                          pathImage: 'assets/gif/sinhhoc.gif',
                        ),
                        Topic(
                          colors: MoreGradientColors.instagram,
                          title: 'Lịch Sử',
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DifficultyScreen(topic: 2),
                            ));
                          },
                          pathImage: 'assets/gif/lichsu.gif',
                        ),
                        Topic(
                          colors: MoreGradientColors.lunada,
                          title: 'Địa Lý',
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DifficultyScreen(topic: 3),
                            ));
                          },
                          pathImage: 'assets/gif/dialy.gif',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
