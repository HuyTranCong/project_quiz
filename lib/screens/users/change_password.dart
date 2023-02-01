import 'package:animated_button/animated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/provider/auth_page.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isHidden = false;

  final formKey = GlobalKey<FormState>();

  var newPassword = " ";

  final newPassswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AuthPage()),
            (route) => false);
      }
    });
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;

  changePassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await currentUser!.updatePassword(newPassword);
      await auth.signOut();
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AuthPage(),
      //     ),
      //     (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content:
              Text('Mật khẩu đã được thay đổi... Vui lòng Đăng Nhập lại!')));
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    newPassswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
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
          title: Text('Hồ Sơ',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/avatar.png',
                width: size.width / 2,
                height: size.width / 2,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                            color: Color(0xFF09031D).withOpacity(.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            autofocus: false,
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
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? 'Mật khẩu tối thiểu 6 ký tự'
                                    : null,
                          ),
                        ),

                        //capnhat
                        AnimatedButton(
                          color: Colors.red,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                newPassword = newPassswordController.text;
                              });
                              changePassword();
                            }
                          },
                          child: Text(
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
            ],
          ),
        ),
      ),
    );
  }

  //hide_show pass
  void togglePassword() => setState(() => isHidden = !isHidden);
}
