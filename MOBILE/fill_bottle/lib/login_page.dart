// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fill_bottle/helper/dbhelper.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/register_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:websafe_svg/websafe_svg.dart';
import 'package:sign_button/sign_button.dart';

class LoginPage extends StatefulWidget {
  final String nav;
  const LoginPage({Key key, this.nav}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _isObpass = true;
  DbHelper dbHelper = DbHelper();

  _updateKeranjang(String userid) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    var cek = await db.query('keranjang');
    if (cek.length < 1) {
      db.execute('update keranjang set userid=?', [userid]);
    }
    await batch.commit();
  }

  _showAlertDialog(BuildContext context, String e) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(e),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  _login() async {
    final prefs = await SharedPreferences.getInstance();
    var params = "/api/login";
    var url =
        Uri.http(sUrl, params, {"email": user.text, "password": pass.text});
    var res = await http.post(url);
    if (res.statusCode == 200) {
      print(url);
      var response = json.decode(res.body);
      print(response);
      if (response[0]['level'] == '2') {
        prefs.setBool('login', true);
        prefs.setInt('id', response[0]['id']);
        prefs.setString('email', response[0]['email']);
        prefs.setString('name', response[0]['name']);
        prefs.setString('level', response[0]['level']);
        if (widget.nav == "") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/landingusers', (route) => false);
        } else {
          _updateKeranjang(response[0]['id']);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/keranjangusers', (route) => false);
        }
      } else if (response[0]['level'] == '3') {
        prefs.setBool('login', true);
        prefs.setInt('id', response[0]['id']);
        prefs.setString('email', response[0]['email']);
        prefs.setString(
            'name', response[0]['name'] + ' ' + response[0]['last_name']);
        prefs.setString('level', response[0]['level']);
        if (widget.nav == "") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/landingusers', (route) => false);
        } else {
          _updateKeranjang(response[0]['id']);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/landingusers', (route) => false);
        }
      } else {
        _showAlertDialog(context, response['response_message']);
        setState(() {
          user.text = "";
          pass.text = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text("Login"),
        // ),
        body: SingleChildScrollView(
      // reverse: true,
      child: Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 15, left: 20),
                child: Text(
                  "Login to your",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 19, 19)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Account\n",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 159, 94, 238))),
              ),

              Padding(padding: EdgeInsets.only(bottom: 15)),
              // Icon(Icons.image, size: 333, color: Colors.white),
              Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 73, 73)),
                        controller: user,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 67, 62, 62),
                            width: 2,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 75, 69, 69),
                            width: 2,
                          )),
                          focusColor: Color.fromARGB(255, 63, 59, 59),
                          hintText: "Email",
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 74, 71, 71),
                          ),
                          prefixIcon: Icon(Icons.person,
                              color: Color.fromARGB(255, 64, 60, 60)),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email cannot be empty';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        style:
                            TextStyle(color: Color.fromARGB(255, 64, 60, 60)),
                        controller: pass,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'password cannot be empty';
                          } else if (text.length < 8) {
                            return "Enter valid password of more then 8 characters!";
                          }
                        },
                        obscureText: _isObpass,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 64, 60, 60),
                            width: 2,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 64, 60, 60),
                            width: 2,
                          )),
                          focusColor: Color.fromARGB(255, 64, 60, 60),
                          hintText: "Password",
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 64, 60, 60),
                          ),
                          prefixIcon: Icon(Icons.lock,
                              color: Color.fromARGB(255, 64, 60, 60)),
                          suffixIcon: IconButton(
                            icon: _isObpass
                                ? Icon(
                                    Icons.visibility,
                                    color: Color.fromARGB(255, 64, 60, 60),
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Color.fromARGB(255, 64, 60, 60),
                                  ),
                            onPressed: () {
                              setState(
                                () {
                                  _isObpass = !_isObpass;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // NOTE: BUTTON LOGIN
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            final isValid = _form.currentState.validate();
                            if (!isValid) {
                              return;
                            } else {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => LandingPage()));
                              _login();
                            }
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              primary: Color.fromARGB(255, 159, 94, 238),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Or Continue With'),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SignInButton.mini(
                          buttonType: ButtonType.facebook,
                          onPressed: () {},
                        ),
                        SignInButton.mini(
                          buttonType: ButtonType.google,
                          onPressed: () {},
                        ),
                        SignInButton.mini(
                          buttonType: ButtonType.github,
                          onPressed: () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: ,
                      children: [
                        SizedBox(height: 10),
                        Text("Don’t have an account?",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 50, 49, 49))),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(" Register",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 50, 49, 49),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
