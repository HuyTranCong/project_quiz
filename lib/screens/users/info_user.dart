import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project_quizz/main.dart';
import 'package:project_quizz/screens/users/signin.dart';

class InfoUserScreen extends StatefulWidget {
  InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  final fabKey = GlobalKey<FabCircularMenuState>();

  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  int exp = 0;

  Future getId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            final r = document.data() as Map<String, dynamic>;
            try {
              setState(() {
                name = r['username'];
                exp = r['exp'];
              });
            } catch (e) {
              print(e.toString());
            }
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    getId();
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
          title: const Text('Thông tin cá nhân',
              style: TextStyle(color: Colors.black, fontSize: 30)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.purple),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
                height: size.height / 3,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.9),
                      offset: Offset(3, 10),
                      blurRadius: 1000)
                ]),
                child: Image.asset(
                  'assets/images/image_03.jpg',
                  width: size.width,
                  fit: BoxFit.cover,
                )),
            Positioned(
              top: size.height / 4,
              left: size.width / 4,
              child: Image.asset(
                'assets/images/avatar.png',
                width: size.width / 2,
                height: size.width / 2,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: size.width,
                  height: size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //username
                      SizedBox(
                        child: ListTile(
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          leading:
                              Icon(Icons.account_circle_outlined, size: 40),
                          title: Text(
                            '$name',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: Icon(Icons.arrow_circle_right_outlined),
                          onTap: () {},
                        ),
                      ),

                      //email
                      SizedBox(
                        child: ListTile(
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          leading: Icon(Icons.email_outlined, size: 40),
                          title: Text(
                            user.email!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),
                          ),
                          onTap: () {},
                        ),
                      ),

                      //level
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Level',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: size.height / 20,
                                width: size.width / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: size.height / 20,
                                width: size.width / 2 * ((exp / 100) % 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.amberAccent,
                                ),
                              ),
                              SizedBox(
                                height: size.height / 20,
                                width: size.width / 2,
                                child: Center(
                                  child: Text(
                                    (exp ~/ 100).toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //coin (cua hang)
                      SizedBox(
                        width: size.width / 2,
                        child: ListTile(
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          leading: Icon(Icons.attach_money_outlined, size: 40),
                          title: const Text(
                            '1000',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Icon(Icons.arrow_circle_right_outlined),
                          onTap: () {},
                        ),
                      ),

                      //dang xuat
                      AnimatedButton(
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text('Do you want to Sign Out?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      navigatorKey.currentState?.push(
                                          MaterialPageRoute(
                                              builder: (_) => SignInScreen(
                                                  onClickedSignUp: () {})));
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Colors.red,
                                      ),
                                    ),
                                    child: const Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Đăng Xuất',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
