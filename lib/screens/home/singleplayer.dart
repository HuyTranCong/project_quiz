import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_quizz/components/option_topic.dart';

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
                delay: Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Column(
                      children: [
                        Topic(
                          color: Colors.amber,
                          title: 'Sinh Học',
                          press: () {},
                          pathImage: 'assets/gif/sinhhoc.gif',
                        ),
                        Topic(
                          color: Colors.blue,
                          title: 'Lịch Sử',
                          press: () {},
                          pathImage: 'assets/gif/lichsu.gif',
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
