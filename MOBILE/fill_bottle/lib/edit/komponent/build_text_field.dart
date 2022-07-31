// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController control;
  final String hint, label;
  final IconData icon;
  final dynamic validasi;
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
          keyboardType: input,
          style: TextStyle(color: Colors.black),
          controller: control,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            focusColor: Colors.white,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black26),
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            prefixIcon: Icon(icon, color: Colors.black26),
          ),
          validator: validasi),
    );
  }
}
