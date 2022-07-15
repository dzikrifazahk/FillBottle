// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController control;
  final String hint, label;
  final IconData icon;
  final Function validasi;
  final TextInputType input;
  const BuildTextField({
    Key key,
    this.control,
    this.hint,
    this.label,
    this.icon,
    this.validasi,
    this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
          keyboardType: input,
          style: TextStyle(color: Colors.black),
          controller: control,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            )),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            )),
            focusColor: Colors.white,
            hintText: hint,
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.blue,
            ),
            prefixIcon: Icon(icon, color: Colors.blue),
          ),
          validator: validasi),
    );
  }
}
