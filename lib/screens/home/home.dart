import 'dart:async';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_quiz/components/menu.dart';
import 'package:project_quiz/models/data_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final fabKey = GlobalKey<FabCircularMenuState>();

  var currentPage = images.length - 1.0;

  bool isTapped = false;

  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  int exp = 1;

  // getId
  Future getId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              final r = document.data() as Map<String, dynamic>;
              try {
                setState(() {
                  name = r['username'];
                  exp = r['exp'];
                });
              } catch (e) {
                print(e.toString());
              }
            }));
  }

  //Disable Back Button
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App?'),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  }),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    getId();
    Size size = MediaQuery.of(context).size;

    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    // return Scaffold(
    //   body: Container(
    //     color: const Color(0xFF192A56),
    //     child: Column(
    //       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         //name
    //         Center(
    //           child: Text(
    //             '$name',
    //             style: TextStyle(
    //               color: Colors.white.withOpacity(.7),
    //               fontWeight: FontWeight.w500,
    //               fontSize: 20,
    //             ),
    //           ),
    //         ),

    //         //email
    //         Text(user.email!),

    //         //exit
    //         ElevatedButton.icon(
    //           icon: const Icon(Icons.exit_to_app_outlined),
    //           onPressed: () {
    //             showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   title: const Text('Thoát Ứng Dụng'),
    //                   content: const Text('Bạn có chắc muốn Thoát?'),
    //                   actions: <Widget>[
    //                     ElevatedButton(
    //                         child: const Text('Có'),
    //                         onPressed: () {
    //                           if (Platform.isAndroid) {
    //                             SystemNavigator.pop();
    //                           } else {
    //                             exit(0);
    //                           }
    //                         }),
    //                     ElevatedButton(
    //                         style: const ButtonStyle(
    //                           backgroundColor:
    //                               MaterialStatePropertyAll(Colors.red),
    //                         ),
    //                         child: const Text('Không'),
    //                         onPressed: () {
    //                           Navigator.of(context).pop();
    //                         }),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //           label: Text('THOÁT'),
    //         ),

    //         //logout
    //         ElevatedButton.icon(
    //           icon: const Icon(Icons.logout_outlined),
    //           onPressed: () {
    //             showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   title: const Text('Đăng Xuất Tài Khoản'),
    //                   content: const Text('Bạn có chắc muốn Đăng Xuất?'),
    //                   actions: <Widget>[
    //                     ElevatedButton(
    //                         child: const Text('Có'),
    //                         onPressed: () {
    //                           FirebaseAuth.instance.signOut();
    //                           navigatorKey.currentState?.push(
    //                             MaterialPageRoute(
    //                                 builder: (_) =>
    //                                     SignInScreen(onClickedSignUp: () {})),
    //                           );
    //                         }),
    //                     ElevatedButton(
    //                       style: const ButtonStyle(
    //                         backgroundColor:
    //                             MaterialStatePropertyAll(Colors.red),
    //                       ),
    //                       child: const Text('Không'),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //           label: Text('ĐĂNG XUẤT'),
    //         ),
    //       ],
    //     ),
    //   ),

    //   //menu
    //   floatingActionButton: Builder(
    //     builder: (context) => FabCircularMenu(
    //       key: fabKey,
    //       alignment: Alignment.bottomRight,
    //       ringColor: Colors.white.withAlpha(25),
    //       ringDiameter: 500.0,
    //       ringWidth: 150.0,
    //       fabSize: 60.0,
    //       fabElevation: 8.0,
    //       fabIconBorder: const CircleBorder(
    //           side: BorderSide(color: Colors.white, width: 3)),
    //       fabColor: const Color(0xFF192A56),
    //       fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
    //       fabCloseIcon: const Icon(Icons.close, color: Colors.amber),
    //       fabMargin: const EdgeInsets.all(16.0),
    //       animationDuration: const Duration(milliseconds: 800),
    //       animationCurve: Curves.easeInOutCirc,
    //       onDisplayChange: ((isOpen) {}),
    //       children: <Widget>[
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.settings_applications_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.shopping_cart_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.account_circle_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.house_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    //===================================
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
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
          //menu
          floatingActionButton: Builder(
            builder: (context) => Menu(fabKey: fabKey),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //time
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.red),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                //name
                Column(
                  children: [
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Xin Chào ',
                              style: TextStyle(fontSize: 26.0)),
                          TextSpan(
                              text: '$name',
                              style: TextStyle(
                                  fontSize: 30, color: Colors.red.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 50),

                //button play
                Container(
                  width: size.width,
                  // height: size.height / 4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/image_4.gif'),
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                            child: InkWell(
                              highlightColor: Colors.black.withOpacity(.6),
                              splashColor: Colors.white.withOpacity(.4),
                              onTap: () {},
                            ),
                          ),
                          Ink.image(
                            image: AssetImage('assets/images/image_1.gif'),
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                            child: InkWell(
                              highlightColor: Colors.black.withOpacity(.6),
                              splashColor: Colors.white.withOpacity(.4),
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 50),
                Container(
                  width: size.width,
                  // height: size.height / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Lịch sử chơi đơn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AnimatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Bảng xếp hạng',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AnimatedButton(
                        width: size.width / 4,
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content:
                                    const Text('Do you want to Exit Game?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      if (Platform.isAndroid) {
                                        SystemNavigator.pop();
                                      } else {
                                        exit(0);
                                      }
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
                          'Thoát',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
