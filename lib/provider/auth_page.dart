import 'package:flutter/material.dart';
import 'package:project_quizz/screens/users/signin.dart';
import 'package:project_quizz/screens/users/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignInScreen(onClickedSignUp: toggle)
      : SignUpScreen(onClickedSignIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
