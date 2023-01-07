import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      duration: Duration(seconds: 4),
      backgroundColor: Colors.red[600],
      content: SizedBox(
        child: Text(text),
      ),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
