import 'package:flutter/material.dart';

class Topic extends StatelessWidget {
  const Topic({
    Key? key,
    required this.color,
    required this.title,
    required this.press,
    required this.pathImage,
  }) : super(key: key);

  final Color color;
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
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              ElevatedButton(onPressed: press, child: Text('Chơi')),
            ],
          ),
          Image.asset(
            pathImage,
            width: width / 2,
            height: width / 3,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
