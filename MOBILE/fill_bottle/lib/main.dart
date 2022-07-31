// ignore_for_file: prefer_const_constructors

import 'package:fill_bottle/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fill_bottle/introduction/intro.dart';
import 'package:fill_bottle/landing_page.dart';
import 'package:fill_bottle/launcher_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool login = false;
  bool isDark = false;

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      isDark = prefs.getBool('isDark') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    primaryColor: Colors.black,
    primarySwatch: Colors.blue,
    indicatorColor: Color(0xff0E1D36),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    cardColor: Color(0xFF151515),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(
          color: Colors.white,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fill Bottle',
      theme: light,
      home: login ? LandingPage() : LauncherPage(),
      routes: <String, WidgetBuilder>{
        '/intropage': (context) => IntroPage(),
        '/landingusers': (context) => LandingPage(),
        '/keranjangusers': (context) => LandingPage(nav: '2'),
        '/profileusers': (context) => LandingPage(nav: '3'),
        // '/signup': (context) => SignupPage(),
        // '/forgot': (context) => Forgotpage(),
      },
    );
  }
}
