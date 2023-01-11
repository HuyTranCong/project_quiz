import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:project_quiz/provider/auth_page.dart';
import 'package:project_quiz/provider/utils.dart';
import 'package:project_quiz/screens/users/verify_email.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConnectivityResult result;
  late StreamSubscription subcription;
  var isConnected = false;

  @override
  void initState() {
    super.initState();
    startStreaming();
  }

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
      showDialogBox();
    }
    setState(() {});
  }

  showDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error_outline_outlined, size: 30),
        iconColor: Colors.red,
        title: const Text('No Internet',
            style: TextStyle(fontSize: 40, color: Colors.red)),
        content: const Text(
          'Vui lòng kiểm tra kết nối Internet của bạn!',
          style: TextStyle(fontSize: 18, letterSpacing: 2),
          textAlign: TextAlign.center,
        ),
        actions: [
          CupertinoButton.filled(
            child: const Text('Thử lại'),
            onPressed: () {
              Navigator.pop(context);
              checkInternet();
            },
          ),
        ],
      ),
    );
  }

  startStreaming() {
    subcription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Có lỗi xảy ra!'));
        } else if (snapshot.hasData) {
          return VerifyEmailPage();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}
