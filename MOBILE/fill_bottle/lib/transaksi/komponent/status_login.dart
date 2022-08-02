// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:fill_bottle/transaksi/komponent/detail_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/model/penjualan.dart';
import 'package:fill_bottle/transaksi/komponent/item_list.dart';

class StatusLogin extends StatefulWidget {
  final String userid;
  const StatusLogin({Key key, this.userid}) : super(key: key);

  @override
  _StatusLoginState createState() => _StatusLoginState();
}

class _StatusLoginState extends State<StatusLogin> {
  List<dynamic> transaksiList = [];
  String iUrl = Uri.http(sUrl, "/CodeIgniter3").toString();

  Future fetchTransaksi(String id) async {
    var params = "/api/showTransaction/" + id;
    var url = Uri.http(sUrl, params);
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Lihat Semua Transaksi",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: fetchTransaksi(widget.userid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.white70,
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(snapshot.data[index]);
                            return ItemList(transaksi: snapshot.data[index]);
                          }),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
