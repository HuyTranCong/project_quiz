import 'package:animated_button/animated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/provider/auth_page.dart';
import 'package:project_quizz/provider/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isHidden = false;

  final formKey = GlobalKey<FormState>();

  final currentUser = FirebaseAuth.instance.currentUser;

  final newPassswordController = TextEditingController();
  var newPassword = "";

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.black.withOpacity(.8),
                      offset: const Offset(1, 10),
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //pass
                        Container(
                          width: size.width / 1.2,
                          height: size.height / 14,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right: size.width / 30),
                          decoration: BoxDecoration(
                            color: const Color(0xFF09031D).withOpacity(.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            style:
                                TextStyle(color: Colors.white.withOpacity(.9)),
                            keyboardType: TextInputType.text,
                            controller: newPassswordController,
                            obscureText: !isHidden,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white.withOpacity(.7),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: togglePassword,
                                  icon: isHidden
                                      ? Icon(Icons.visibility_outlined,
                                          color: Colors.white.withOpacity(.5))
                                      : Icon(Icons.visibility_off_outlined,
                                          color: Colors.white.withOpacity(.5))),
                              border: InputBorder.none,
                              hintMaxLines: 1,
                              hintText: 'Mật khẩu mới...',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? 'Mật khẩu tối thiểu 6 ký tự'
                                    : null,
                          ),
                        ),

                        //capnhat
                        AnimatedButton(
                          color: Colors.red,
                          onPressed: () {},
                          child: const Text(
                            'Cập Nhật',
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
            ),
          ],
        ),
      ),
    );
  }

  //hide_show pass
  void togglePassword() => setState(() => isHidden = !isHidden);
}
