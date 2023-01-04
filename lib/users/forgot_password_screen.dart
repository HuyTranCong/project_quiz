import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:rive/rive.dart' as Rive;

import '../components/utils.dart';
import '../main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Lock Device Orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    //End Lock Device Orientation

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
    //Lock Device Orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    //End Lock Device Orientation

    emailController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      backgroundColor: Color(0xFF292C31),
      body: Stack(
        children: [
          // Positioned.fill(
          //     child: Rive.RiveAnimation.asset(
          //         "assets/rive_assets/lionel_animation.riv")),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: _height,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),

                    //text-field
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          const Text(
                            'NHẬP EMAIL ĐỂ ĐẶT LẠI MẬT KHẨU CỦA BẠN!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFA9DED8)),
                          ),
                          const SizedBox(),

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
                              controller: emailController,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.9)),
                              keyboardType: TextInputType.emailAddress,
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
                        ],
                      ),
                    ),

                    //button resetPassword
                    Expanded(
                      flex: 3,
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
                                onTap: resetPassword,
                                child: Container(
                                  height: _width * .3,
                                  width: _width * .3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFA0DED8).withOpacity(.5),
                                      shape: BoxShape.circle),
                                  child: const Text(
                                    'XÁC NHẬN',
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

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Vui lòng kiểm tra Email');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
