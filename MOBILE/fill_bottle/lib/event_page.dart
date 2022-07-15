import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            Container(
              height: 115,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color(0xFFA3A5F1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                    ),
                  ]),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 0,
                    child: Container(
                      height: 50,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 42,
                    left: 20,
                    child: Text(
                      "Let's join the event",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff4448ae),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                    child: Material(
                      child: Container(
                          height: 150.0,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 234, 250),
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                    ),
                  ),
                  Positioned(
                    child: Card(
                      elevation: 10.0,
                      shadowColor:
                          Color.fromARGB(255, 29, 11, 11).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Container(
                        height: 2000,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/braga.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 170,
                    child: Text(
                      "NGABARAGA",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 170,
                    child: Text(
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Positioned(
                    child: Material(
                      child: Container(
                          height: 150.0,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 234, 250),
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                    ),
                  ),
                  Positioned(
                    child: Card(
                      elevation: 10.0,
                      shadowColor:
                          Color.fromARGB(255, 29, 11, 11).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Container(
                        height: 2000,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/gedungsate.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 170,
                    child: Text(
                      "NYATE",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 170,
                    child: Text(
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Positioned(
                    child: Material(
                      child: Container(
                          height: 150.0,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 234, 250),
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                    ),
                  ),
                  Positioned(
                    child: Card(
                      elevation: 10.0,
                      shadowColor:
                          Color.fromARGB(255, 29, 11, 11).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Container(
                        height: 2000,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage('assets/images/geologi.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 170,
                    child: Text(
                      "NGAMPUSE",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 170,
                    child: Text(
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Positioned(
                    child: Material(
                      child: Container(
                          height: 150.0,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 234, 250),
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                    ),
                  ),
                  Positioned(
                    child: Card(
                      elevation: 10.0,
                      shadowColor:
                          Color.fromARGB(255, 29, 11, 11).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Container(
                        height: 2000,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/braga.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 170,
                    child: Text(
                      "Braga",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 170,
                    child: Text(
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
