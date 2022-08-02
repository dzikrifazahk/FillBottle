import 'dart:convert';

import 'package:fill_bottle/edit/edit_page.dart';
import 'package:fill_bottle/home/komponents/build_button.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/profil/komponents/image_with_icon.dart';
import 'package:fill_bottle/profil/komponents/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProfile extends StatefulWidget {
  final String email, nama, level;
  final int userid;
  const LoginProfile({Key key, this.email, this.userid, this.nama, this.level})
      : super(key: key);

  @override
  State<LoginProfile> createState() => _LoginProfileState();
}

class _LoginProfileState extends State<LoginProfile> {
  bool isSwitched = false;

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/profileusers', (route) => false);
  }

  void toggleSwitch(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isDark', value);
      isSwitched = prefs.getBool('isDark');
    });
  }

  Future getData() async {
    var params = "/api/showCustomer/" + widget.userid.toString();
    var url = Uri.http(sUrl, params);
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
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
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/images/service.png',
                // color: Colors.white,
                width: 28,
                height: 28,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getData(),
                builder: (context, s) {
                  if (!s.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: ImageWithIcon(
                      image: s.data[0]['customer']['foto'],
                      kode: s.data[0]['kode'],
                      userid: widget.userid,
                    ),
                  );
                }),
            SizedBox(height: 10),
            Text(
              widget.nama,
              style: TextStyle(
                fontSize: 24,
                // color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 14,
                // color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditPage(
                                      userid: widget.userid,
                                    )));
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 20),
                                    width: 28,
                                    height: 28,
                                    child: Icon(Icons.person)),
                                Text(
                                  "Edit Profil",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Wallet");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 28,
                                  height: 28,
                                  child: Icon(Icons.wallet)),
                              Text(
                                "Wallet",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Notifications");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 28,
                                  height: 28,
                                  child: Icon(Icons.notification_important)),
                              Text(
                                "Notifications",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Make Event");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 28,
                                  height: 28,
                                  child: Icon(Icons.shield)),
                              Text(
                                "Make Event",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Security");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 28,
                                  height: 28,
                                  child: Icon(Icons.shield_rounded)),
                              Text(
                                "Security",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TutorialPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 28,
                                  height: 28,
                                  child: Icon(Icons.help_center)),
                              Text(
                                "Help",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Dark Theme");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 20),
                                      width: 28,
                                      height: 28,
                                      child: Icon(Icons.remove_red_eye)),
                                  Text(
                                    "Dark Theme",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: toggleSwitch,
                                value: isSwitched,
                                activeColor: Color.fromARGB(255, 159, 94, 238),
                                activeTrackColor:
                                    Color.fromARGB(255, 163, 165, 241),
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            return _logout();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 28,
                                  height: 28,
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  )),
                              Text(
                                "Logout",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
