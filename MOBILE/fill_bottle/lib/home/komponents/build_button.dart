// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function press;
  const BuildButton({
    Key key,
    this.title,
    this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 190,
      child: ElevatedButton(
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 5),
            Text(title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 163, 165, 241),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
