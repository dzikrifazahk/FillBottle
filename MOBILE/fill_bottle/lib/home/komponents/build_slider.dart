// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fill_bottle/temukan_page.dart';
import 'package:flutter/material.dart';
import 'package:fill_bottle/home/komponents/item_card.dart';
import 'package:fill_bottle/model/cabang.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:http/http.dart' as http;

class BuildSlider extends StatefulWidget {
  const BuildSlider({Key key}) : super(key: key);

  @override
  State<BuildSlider> createState() => _BuildSliderState();
}

class _BuildSliderState extends State<BuildSlider> {
  int _currentIndex = 0;
  List<int> cardList = [1, 2, 3];
  List<Cabang> cabangList = [];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future<List<Cabang>> fecthBranch() async {
    List<Cabang> usersList;
    var params = "/api/branch";
    var url = Uri.http(sUrl, params);
    try {
      var response = await http.get(url);
      // print(json.decode(response.body));
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Cabang>((json) {
          return Cabang.fromJson(json);
        }).toList();
        setState(() {
          cabangList = usersList;
        });
      }
    } catch (e) {
      usersList = cabangList;
    }
    return usersList;
    // print(usersList);
  }

  @override
  void initState() {
    super.initState();
    fecthBranch();
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
                    "Cabang Kami",
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
                itemCount: cabangList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://fillbottle.nataysa.com/storage' +
                                  "/" +
                                  cabangList[index].foto,
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
                          cabangList[index].nama,
                          style: TextStyle(
                              color: Color.fromARGB(255, 163, 165, 241),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          cabangList[index].kota,
                          style: TextStyle(
                            color: Color.fromARGB(255, 163, 165, 241),
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
