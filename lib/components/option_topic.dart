import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

class Topic extends StatelessWidget {
  const Topic({
    Key? key,
    required this.colors,
    required this.title,
    required this.press,
    required this.pathImage,
  }) : super(key: key);

  final List<Color> colors;
  final String title;
  final VoidCallback press;
  final String pathImage;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: width / 20),
      width: width,
      height: width / 3,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius:  BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.8),
            blurRadius: 40,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding:  EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                
                AnimatedButton(
                  color: Colors.red,
                  width: 100,
                  height: 50,
                  onPressed: press,
                  child:  Text(
                    'Chơi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            pathImage,
            width: width / 2,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
