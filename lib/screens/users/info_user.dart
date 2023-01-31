import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_quizz/main.dart';
import 'package:project_quizz/provider/auth_page.dart';
import 'package:project_quizz/screens/users/change_password.dart';

class InfoUserScreen extends StatefulWidget {
  InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  final fabKey = GlobalKey<FabCircularMenuState>();
  final auth = FirebaseAuth.instance;
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
            final r = document.data();
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
              tileMode: TileMode.clamp)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hồ Sơ',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Image.asset(
              'assets/images/avatar.png',
              width: size.width / 2,
              height: size.width / 2,
              fit: BoxFit.cover,
            ),

            //info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: size.width,
                height: size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //username
                    SizedBox(
                      child: ListTile(
                        tileColor: Colors.purple.withOpacity(.2),
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading:
                            const Icon(Icons.account_circle_outlined, size: 40),
                        title: Text(
                          '$name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20),
                        ),
                        trailing: Icon(Icons.arrow_circle_right_outlined),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ));
                        },
                      ),
                    ),

                    //email
                    SizedBox(
                      child: ListTile(
                        tileColor: Colors.purple.withOpacity(.2),
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
                        tileColor: Colors.purple.withOpacity(.2),
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
                        FirebaseAuth.instance.signOut();
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       title: const Text('Are you sure?'),
                        //       content: const Text('Do you want to Sign Out?'),
                        //       actions: <Widget>[
                        //         ElevatedButton(
                        //           onPressed: () {
                        //             FirebaseAuth.instance.signOut();

                        //             // navigatorKey.currentState
                        //             //     ?.pushAndRemoveUntil(
                        //             //         MaterialPageRoute(
                        //             //           builder: (context) => AuthPage(),
                        //             //         ),
                        //             //         (route) => false);
                        //           },
                        //           child: const Text('Yes'),
                        //         ),
                        //         ElevatedButton(
                        //           onPressed: () {
                        //             Navigator.of(context).pop();
                        //           },
                        //           style: const ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll(
                        //               Colors.red,
                        //             ),
                        //           ),
                        //           child: const Text('No'),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
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
          ],
        ),
      ),
    );
  }
}
