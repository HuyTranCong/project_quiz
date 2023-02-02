import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/screens/home/home.dart';
import 'package:project_quizz/screens/setting/setting.dart';
import 'package:project_quizz/screens/users/info_user.dart';

class Menu extends StatelessWidget {
  Menu({
    Key? key,
    required this.fabKey,
  }) : super(key: key);

  final GlobalKey<FabCircularMenuState> fabKey;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey,
      alignment: Alignment.bottomRight,
      ringColor: Colors.white.withAlpha(80),
      ringDiameter: 400.0,
      ringWidth: 80.0,
      fabSize: 60.0,
      fabIconBorder:
          CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
      fabColor: Colors.transparent,
      fabOpenIcon: Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: Icon(Icons.close, color: Colors.white),
      fabMargin: EdgeInsets.all(16.0),
      animationDuration: Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: ((isOpen) {}),
      children: <Widget>[
        //setting
        RawMaterialButton(
          fillColor: Color(0xFF192A56).withOpacity(.8),
          focusColor: Colors.red,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SettingScreen(),
            ));
          },
          shape: CircleBorder(),
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),

        //shop
        RawMaterialButton(
          fillColor: Color(0xFF192A56).withOpacity(.8),
          focusColor: Colors.red,
          onPressed: () {},
          shape: CircleBorder(),
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),

        //info
        RawMaterialButton(
            fillColor: Color(0xFF192A56).withOpacity(.8),
            focusColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InfoUserScreen()),
              );
            },
            shape: CircleBorder(),
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 30,
            )),

        //home
        //pushAndRemoveUntil: xoá toàn bộ route và return route mới
        RawMaterialButton(
            fillColor: Color(0xFF192A56).withOpacity(.8),
            focusColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
            shape: CircleBorder(),
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.house_outlined,
              color: Colors.white,
              size: 30,
            )),
      ],
    );
  }
}
