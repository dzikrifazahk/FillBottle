// ignore_for_file: prefer_const_constructors

import 'dart:convert';

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
  List<Penjualan> penjualanList = [];
  String iUrl = Uri.http(sUrl, "/CodeIgniter3").toString();

  Future<List<Penjualan>> fetchPenjualan(String id) async {
    List<Penjualan> usersList;
    var params = "/CodeIgniter3/transaksibypelanggan";
    var url = Uri.http(sUrl, params, {"id": id});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Penjualan>((json) {
          return Penjualan.fromJson(json);
        }).toList();
        setState(() {
          penjualanList = usersList;
        });
      }
    } catch (e) {
      usersList = penjualanList;
    }
    return usersList;
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
          child: FutureBuilder<List<Penjualan>>(
              future: fetchPenjualan(widget.userid),
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
                            return ItemList(
                              nota: snapshot.data[index].nota,
                              tanggal: snapshot.data[index].tanggal,
                              st: snapshot.data[index].st,
                            );
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
