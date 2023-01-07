import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:project_quizz/provider/utils.dart';
import 'package:project_quizz/main.dart';


class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpScreen({super.key, required this.onClickedSignIn});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final formKey = GlobalKey<FormState>();

  //textController
  final displayname = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    displayname.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF292C31),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: _height,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),

                      //text-field
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            const Text(
                              'ĐĂNG KÝ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFA9DED8),
                              ),
                            ),
                            SizedBox(),

                            //username textfield
                            Container(
                              // height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xFF212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.9),
                                ),
                                keyboardType: TextInputType.text,
                                controller: displayname,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle_outlined,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Tên tài khoản...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value != null && value.length < 3
                                        ? 'Tên tài khoản phải trên 3 ký tự '
                                        : null,
                              ),
                            ),

                            //email textfield
                            Container(
                              // height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xFF212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9)),
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Email...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Email không hợp lệ!'
                                    : null,
                              ),
                            ),

                            //password textfield
                            Container(
                              // height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xFF212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9)),
                                keyboardType: TextInputType.text,
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Mật khẩu...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value != null && value.length < 6
                                        ? 'Mật khẩu tối đa 6 ký tự'
                                        : null,
                              ),
                            ),

                            //confirm password textfield
                            Container(
                              // height: _width / 8,
                              width: _width / 1.22,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: _width / 30),
                              decoration: BoxDecoration(
                                color: Color(0xFF212428),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9)),
                                keyboardType: TextInputType.text,
                                controller: confirmpasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  border: InputBorder.none,
                                  hintMaxLines: 1,
                                  hintText: 'Xác nhận mật khẩu...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return passwordController.text == value
                                      ? null
                                      : "Mật khẩu không trùng khớp!";
                                },
                              ),
                            ),

                            //already an account? sign in
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color(0xFF212428).withOpacity(.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Đã có tài khoản! ĐĂNG NHẬP',
                                      style: const TextStyle(
                                        color: Color(0xFFA9DED8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = widget.onClickedSignIn,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //button sign-un
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: _width * .07),
                                height: _width * .7,
                                width: _width * .7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Color(0xFF09090A)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Transform.scale(
                                scale: _animation.value,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: SignUp,
                                  child: Container(
                                    height: _width * .3,
                                    width: _width * .3,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFA0DED8).withOpacity(.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Text(
                                      'ĐĂNG KÝ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
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
          ),
        ],
      ),
    );
  }

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      addUserDetails(
        displayname.text.trim(),
        emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future addUserDetails(String displayname, String email) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'username': displayname,
      'email': email,
      'photoUrl': null,
      'score': 0,
      'exp': 1,
      'date': Timestamp.now(),
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
