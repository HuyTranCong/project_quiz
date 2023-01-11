import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_quiz/main.dart';
import 'package:project_quiz/screens/users/signin.dart';

class InfoUserScreen extends StatelessWidget {
  InfoUserScreen({super.key});

  final fabKey = GlobalKey<FabCircularMenuState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF09031D),
          Color(0xFF1B1E44),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        tileMode: TileMode.clamp,
      )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Color(0xFF09031D)),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: size.height / 2,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/image_3.gif'),
                      fit: BoxFit.cover,
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    //dang xuat
                    ElevatedButton.icon(
                      icon: const Icon(Icons.logout_outlined),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content:
                                      const Text('Do you want to Sign Out?'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          navigatorKey.currentState?.push(
                                              MaterialPageRoute(
                                                  builder: (_) => SignInScreen(
                                                      onClickedSignUp: () {})));
                                        }),
                                    ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.red)),
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })
                                  ]);
                            });
                      },
                      label: Text('ĐĂNG XUẤT'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
