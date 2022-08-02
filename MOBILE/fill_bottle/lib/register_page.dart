// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches

import 'package:flutter/material.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/landing_page.dart';
import 'package:fill_bottle/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:fill_bottle/profil/profil_page.dart';
import 'profil/komponents/image_with_icon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController namaDepan = TextEditingController();
  TextEditingController namaBelakang = TextEditingController();
  TextEditingController telepon = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  bool _isObpass = true;
  bool _isObcpass = true;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  _createAccount() async {
    String params = '/api/customer';
    var url = Uri.http(sUrl, params);
    Map<String, String> body = {
      "name": namaDepan.text,
      "last_name": namaBelakang.text,
      "telp": telepon.text,
      "email": email.text,
      "password": password.text
    };

    try {
      final response = await http.post(
        url,
        body: body,
      );

      if (response.statusCode == 200) {
        _scaffold.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Text("Registrasi Sukses", style: TextStyle(color: Colors.black)),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
        setState(() {
          namaDepan.text = "";
          namaBelakang.text = "";
          telepon.text = "";
          email.text = "";
          password.text = "";
          passwordConfirm.text = "";
        });

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      } else {
        _scaffold.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Text("Registration Gagal", style: TextStyle(color: Colors.black)),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
        setState(() {
          // namaDepan.text = "";
          // namaBelakang.text = "";
          // telepon.text = "";
          // email.text = "";
          // password.text = "";
          // passwordConfirm.text = "";
        });
      }
    } catch (e) {}
    return params;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Fill Your Profile",
            style: TextStyle(color: Colors.black),
          ),
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Route route =
                  MaterialPageRoute(builder: (context) => LandingPage());
              Navigator.push(context, route);
            },
            child: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 64, 60, 60),
            ),
          ),
        ),
        key: _scaffold,
        body: SingleChildScrollView(
          // reverse: true,
          child: Container(
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ImageWithIcon(),
                  Image.asset(
                    'assets/images/FillBottleLauncher.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _form,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  controller: namaDepan,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    hintText: "Hanya Contoh",
                                    labelText: 'Nama Depan',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                    ),
                                    prefixIcon: Icon(Icons.person,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Nama depan tidak boleh kosong';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  controller: namaBelakang,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    hintText: "Hanya Contoh",
                                    labelText: 'Nama Belakang',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                    ),
                                    prefixIcon: Icon(Icons.person,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Nama belakang tidak boleh kosong';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Email tidak boleh kosong';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    hintText: "ex@sample.com",
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                    ),
                                    prefixIcon: Icon(Icons.email,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: telepon,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Nomor Telpon Tidak Boleh Kosong';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    hintText: "08xxxxxxxxxxxx",
                                    labelText: 'Telp',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                    ),
                                    prefixIcon: Icon(Icons.call,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  controller: password,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Password Tidak Boleh Kosong';
                                    } else if (text.length < 8) {
                                      return "Password harus lebih 8 karakter!";
                                    }
                                  },
                                  obscureText: _isObpass,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    hintText: "password",
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                    ),
                                    prefixIcon: Icon(Icons.lock,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                    suffixIcon: IconButton(
                                      icon: _isObpass
                                          ? Icon(
                                              Icons.visibility,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 48),
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 48),
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
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  controller: passwordConfirm,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Konfirmasi password harap diisi';
                                    } else if (text != password.text) {
                                      return "Password tidak cocok";
                                    }
                                  },
                                  obscureText: _isObcpass,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      width: 2,
                                    )),
                                    hintText: "password",
                                    labelText: 'Konfirmasi Password',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                    ),
                                    prefixIcon: Icon(Icons.lock,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                    suffixIcon: IconButton(
                                      icon: _isObcpass
                                          ? Icon(
                                              Icons.visibility,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 48),
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 48),
                                            ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            _isObcpass = !_isObcpass;
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

                              // NOTE: BUTTON REGISTER
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: SizedBox(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final isValid =
                                          _form.currentState.validate();
                                      if (!isValid) {
                                        return;
                                      } else {
                                        _createAccount();
                                      }
                                    },
                                    child: Text('Register',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 159, 94, 238),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17))),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Sudah Punya Akun?",
                                      style: TextStyle(fontSize: 18)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilPage()));
                                    },
                                    child: Text(" Masuk",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
