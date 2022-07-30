// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fill_bottle/temukan_page.dart';
import 'package:flutter/material.dart';
import 'package:fill_bottle/home/komponents/item_card.dart';

class BuildSlider extends StatefulWidget {
  const BuildSlider({Key key}) : super(key: key);

  @override
  State<BuildSlider> createState() => _BuildSliderState();
}

class _BuildSliderState extends State<BuildSlider> {
  int _currentIndex = 0;
  List<int> cardList = [1, 2, 3];
  List<String> imgSlider = [
    'assets/images/gedungsate.png',
    'assets/images/geologi.jpeg',
    'assets/images/braga.png',
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Cabang Terpopuler",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TemukanPage()));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Temukan Kami",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.map_sharp,
                          size: 35,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 180,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imgSlider.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              imgSlider[index],
                            ))),
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(8),
                    width: 124,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gedung Bagus",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Jarak",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
