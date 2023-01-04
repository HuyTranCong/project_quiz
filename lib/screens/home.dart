import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_quizz/main.dart';
import 'package:project_quizz/users/signin.dart';
// import 'package:rive/rive.dart' as Rive;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final fabKey = GlobalKey<FabCircularMenuState>();

  bool isTapped = false;

  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  int exp = 1;
  // Future getId() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: user.email)
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((document) {
  //             final r = document.data() as Map<String, dynamic>;
  //             try {
  //               setState(() {
  //                 name = r['username'];
  //                 exp = r['exp'];
  //               });
  //             } catch (e) {
  //               print(e.toString());
  //             }
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    // getId();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: const Color(0xFF292C31),
      body: Container(
        color: const Color(0xFF192A56),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //name
            Row(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onHighlightChanged: (value) {
                    setState(() {
                      isTapped = value;
                    });
                  },
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut,
                    height: isTapped ? 44 : 55,
                    width: isTapped ? size.width / 3 : size.width / 3,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          blurRadius: 30,
                          offset: Offset(3, 7),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$name',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //email
            Text(user.email!),

            //exit
            ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thoát Ứng Dụng'),
                      content: const Text('Bạn có chắc muốn Thoát?'),
                      actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Có'),
                            onPressed: () {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else {
                                exit(0);
                              }
                            }),
                        ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                            ),
                            child: const Text('Không'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    );
                  },
                );
              },
              label: Text('THOÁT'),
            ),

            //logout
            ElevatedButton.icon(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Đăng Xuất Tài Khoản'),
                      content: const Text('Bạn có chắc muốn Đăng Xuất?'),
                      actions: <Widget>[
                        ElevatedButton(
                            child: const Text('Có'),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              navigatorKey.currentState?.push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SignInScreen(onClickedSignUp: () {})),
                              );
                            }),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          child: const Text('Không'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              label: Text('ĐĂNG XUẤT'),
            ),
          ],
        ),
      ),

      //menu
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomRight,
          ringColor: Colors.white.withAlpha(25),
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 60.0,
          fabElevation: 8.0,
          fabIconBorder: const CircleBorder(
              side: BorderSide(color: Colors.white, width: 3)),
          fabColor: const Color(0xFF192A56),
          fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
          fabCloseIcon: const Icon(Icons.close, color: Colors.amber),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: ((isOpen) {}),
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(
                Icons.settings_applications_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(
                Icons.house_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
