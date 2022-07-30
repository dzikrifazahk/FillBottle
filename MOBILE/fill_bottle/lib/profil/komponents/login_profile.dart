import 'package:fill_bottle/profil/komponents/image_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProfile extends StatefulWidget {
  final String userid, nama, level;
  const LoginProfile({Key key, this.userid, this.nama, this.level})
      : super(key: key);

  @override
  State<LoginProfile> createState() => _LoginProfileState();
}

class _LoginProfileState extends State<LoginProfile> {
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/profileusers', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Profil",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: ImageWithIcon(),
          ),
          SizedBox(height: 15),
          Text(
            widget.nama,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            widget.nama,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
