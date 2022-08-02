// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fill_bottle/login_page.dart';
import 'package:fill_bottle/profil/komponents/login_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool login = false;
  int userid;
  String email;
  String nama;
  String level;
  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getInt('id') ?? 0;
      email = prefs.getString('email') ?? "";
      nama = prefs.getString('name') ?? "";
      level = prefs.getString('level') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: login
            ? LoginProfile(
                userid: userid, email: email, nama: nama, level: level)
            : LoginPage());
  }
}
