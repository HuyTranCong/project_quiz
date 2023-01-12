import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/screens/home/home.dart';
import 'package:project_quizz/screens/users/info_user.dart';

class Menu extends StatelessWidget {
  const Menu({
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
          const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
      fabColor: Colors.transparent,
      fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: const Icon(Icons.close, color: Colors.white),
      fabMargin: const EdgeInsets.all(16.0),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: ((isOpen) {}),
      children: <Widget>[
        RawMaterialButton(
          fillColor: const Color(0xFF192A56).withOpacity(.8),
          focusColor: Colors.red,
          onPressed: () {},
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12.0),
          child: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        RawMaterialButton(
          fillColor: const Color(0xFF192A56).withOpacity(.8),
          focusColor: Colors.red,
          onPressed: () {},
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12.0),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        RawMaterialButton(
            fillColor: const Color(0xFF192A56).withOpacity(.8),
            focusColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InfoUserScreen()),
              );
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 30,
            )),

        //pushAndRemoveUntil: xoá toàn bộ route và return route mới
        RawMaterialButton(
            fillColor: const Color(0xFF192A56).withOpacity(.8),
            focusColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.house_outlined,
              color: Colors.white,
              size: 30,
            )),
      ],
    );
  }
}
