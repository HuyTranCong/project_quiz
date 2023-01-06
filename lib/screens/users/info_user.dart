import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_quizz/main.dart';
import 'package:project_quizz/screens/users/signin.dart';

class InfoUserScreen extends StatelessWidget {
  InfoUserScreen({super.key});

  final fabKey = GlobalKey<FabCircularMenuState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF1B1E44),
          Color(0xFF2D3447),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        tileMode: TileMode.clamp,
      )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.blue),
        ),

        //end menu
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
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
                                          builder: (_) => SignInScreen(
                                              onClickedSignUp: () {})));
                                }),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.red)),
                                child: const Text('Không'),
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
    );

    // return Scaffold(
    //   backgroundColor: ,
    //   body: Column(
    //     children: [
    //       //logout
    //       ElevatedButton.icon(
    //         icon: const Icon(Icons.logout_outlined),
    //         onPressed: () {
    //           showDialog(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return AlertDialog(
    //                 title: const Text('Đăng Xuất Tài Khoản'),
    //                 content: const Text('Bạn có chắc muốn Đăng Xuất?'),
    //                 actions: <Widget>[
    //                   ElevatedButton(
    //                       child: const Text('Có'),
    //                       onPressed: () {
    //                         FirebaseAuth.instance.signOut();
    //                         navigatorKey.currentState?.push(
    //                           MaterialPageRoute(
    //                               builder: (_) =>
    //                                   SignInScreen(onClickedSignUp: () {})),
    //                         );
    //                       }),
    //                   ElevatedButton(
    //                     style: const ButtonStyle(
    //                       backgroundColor: MaterialStatePropertyAll(Colors.red),
    //                     ),
    //                     child: const Text('Không'),
    //                     onPressed: () {
    //                       Navigator.of(context).pop();
    //                     },
    //                   ),
    //                 ],
    //               );
    //             },
    //           );
    //         },
    //         label: const Text('ĐĂNG XUẤT'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
