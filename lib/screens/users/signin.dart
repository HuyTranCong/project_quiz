import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_quizz/components/utils.dart';
import 'package:project_quizz/main.dart';
import 'package:project_quizz/screens/users/forgot_password.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignInScreen({super.key, required this.onClickedSignUp});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  //hidden pass
  bool isHidden = false;

  //
  final formKey = GlobalKey<FormState>();

  //animation controller
  late AnimationController _controller;
  late Animation<double> _animation;

  //textController
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //animation
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: .7, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      })
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
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

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
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    //text-field
                    Form(
                      key: formKey,
                      child: Expanded(
                        flex: 2,
                        child: AutofillGroup(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              const Text(
                                'ĐĂNG NHẬP',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFA9DED8)),
                              ),
                              const SizedBox(),

                              //email textfield
                              Container(
                                width: _width / 1.22,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: _width / 30),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF212428),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.9)),
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: [AutofillHints.email],
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined,
                                        color: Colors.white.withOpacity(.7)),
                                    suffixIcon: emailController.text.isEmpty
                                        ? Container(width: 0)
                                        : IconButton(
                                            focusColor: Colors.transparent,
                                            onPressed: () =>
                                                emailController.clear(),
                                            icon: Icon(Icons.close,
                                                color: Colors.white
                                                    .withOpacity(.5))),
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
                                width: _width / 1.22,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: _width / 30),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF212428),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: passwordController,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.9)),
                                  keyboardType: TextInputType.visiblePassword,
                                  autofillHints: [AutofillHints.password],
                                  onEditingComplete: () =>
                                      TextInput.finishAutofillContext(),
                                  obscureText: !isHidden,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: Colors.white.withOpacity(.7)),
                                    suffixIcon: IconButton(
                                        onPressed: togglePassword,
                                        icon: isHidden
                                            ? Icon(Icons.visibility_outlined,
                                                color: Colors.white
                                                    .withOpacity(.5))
                                            : Icon(
                                                Icons.visibility_off_outlined,
                                                color: Colors.white
                                                    .withOpacity(.5))),
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

                              //forgotten password and create a accout
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //forgotten password
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF212428)
                                          .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Quên mật khẩu?',
                                        style: const TextStyle(
                                          color: Color(0xFFA9DED8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordScreen(),
                                                ));
                                          },
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: _width / 30),

                                  //create a new account
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF212428)
                                          .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Chưa có tài khoản? ĐĂNG KÝ',
                                        style: const TextStyle(
                                          color: Color(0xFFA9DED8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = widget.onClickedSignUp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //button sign-in
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
                          //xử lý
                          Center(
                            child: Transform.scale(
                              scale: _animation.value,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: SignIn,
                                child: Container(
                                  height: _width * .3,
                                  width: _width * .3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFA0DED8).withOpacity(.5),
                                      shape: BoxShape.circle),
                                  child: const Text(
                                    'ĐĂNG NHẬP',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
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
        ],
      ),
    );
  }

//hide_show pass
  void togglePassword() => setState(() => isHidden = !isHidden);

//ham dang nhap
  Future SignIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
