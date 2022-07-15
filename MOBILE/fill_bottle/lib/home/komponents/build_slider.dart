// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
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
    'assets/images/geologi.png',
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            items: imgSlider
                .map((item) => Container(
                      child: Center(
                          child: Image.asset(
                        item,
                        // fit: BoxFit.cover,
                        // height: height,
                      )),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(cardList, (index, url) {
              return Container(
                width: _currentIndex == index ? 30 : 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: _currentIndex == index
                      ? Color.fromARGB(255, 159, 94, 238)
                      : Color.fromARGB(255, 202, 111, 223).withOpacity(0.3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
