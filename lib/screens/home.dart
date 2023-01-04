import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/main.dart';
import 'package:project_quizz/users/signin_screen.dart';
// import 'package:rive/rive.dart' as Rive;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isTapped = false;

  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  int exp = 1;
  Future getId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email!)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              final r = document.data();
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

  @override
  Widget build(BuildContext context) {
    getId();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF292C31),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //name
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

              //level
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
                  curve: Curves.fastLinearToSlowEaseIn,
                  //height: isTapped ? 44 : 55,
                  width: size.width / 6 * ((exp / 100) % 1),
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
                      (exp ~/ 100).toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

              //shop
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
                  curve: Curves.fastLinearToSlowEaseIn,
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
          Text(user.email!),

          //logout
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ĐĂNG XUẤT'),
                    content: const Text('Bạn có chắc muốn Đăng Xuất?'),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Đăng Xuất'),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          //Navigator.of(context).pop();
                          navigatorKey.currentState?.push(
                            MaterialPageRoute(
                                builder: (_) => SignInScreen(
                                      onClickedSignUp: () {},
                                    )),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                        ),
                        child: const Text('Huỷ'),
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
    );
  }
}
