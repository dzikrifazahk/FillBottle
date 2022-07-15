// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String title;
  final Function press;
  const BuildButton({
    Key key,
    this.title, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: press,
          child: Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue)),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.blue,
              elevation: 4,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17))),
        ),
      ),
    );
  }
}
