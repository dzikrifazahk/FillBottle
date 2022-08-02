// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, empty_catches, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fill_bottle/helper/dbhelper.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/login_page.dart';
import 'package:fill_bottle/model/keranjang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class KeranjangPage extends StatefulWidget {
  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  DbHelper dbHelper = DbHelper();
  List<Keranjang> keranjanglist = [];
  int _subtotal = 0;
  bool login = false;
  int userid = 0;

  @override
  void initState() {
    super.initState();
    getKeranjang();
    cekLogin();
  }

  loadingProses(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _klikCheckout(List<Keranjang> _keranjang) async {
    loadingProses(context);
    var params = '/api/saveTransaction';
    var body = {
      'userid': userid.toString(),
      'total': _subtotal.toString(),
      'metode': "1",
      'listkeranjang': json.encode(_keranjang),
    };
    var url = Uri.http(sUrl, params);
    http.post(url, body: body).then((value) {
      if (value.statusCode == 200) {
        Navigator.of(context).pop();
        _kosongkanKeranjang();
        _scaffold.currentState.showSnackBar(SnackBar(
            content: Text("Pembelian Berhasil"),
            duration: Duration(seconds: 3)));
      }
    });
    return params;
  }

  Future<List<Keranjang>> getKeranjang() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Keranjang>> listFuture = dbHelper.getKeranjang(userid);
      listFuture.then((_keranjanglist) {
        if (mounted) {
          setState(() {
            keranjanglist = _keranjanglist;
          });
        }
      });
    });
    int subtotal = 0;
    for (int i = 0; i < keranjanglist.length; i++) {
      if (keranjanglist[i].userid == userid) {
        if (keranjanglist[i].harga != "0") {
          subtotal += keranjanglist[i].jumlah * keranjanglist[i].harga;
        }
      } else {
        keranjanglist = [];
      }
    }
    setState(() {
      _subtotal = subtotal;
    });
    return keranjanglist;
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getInt('id') ?? 0;
    });
  }

  _tambahJmlhKeranjang(int id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('update keranjang set jumlah=jumlah+1 where id=?', [id]);
    await batch.commit();
  }

  _kurangJmlhKeranjang(int id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('update keranjang set jumlah=jumlah-1 where id=?', [id]);
    await batch.commit();
  }

  _deleteKeranjang(int id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('delete from keranjang where id=?', [id]);
    await batch.commit();
  }

  _kosongkanKeranjang() async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('delete from keranjang');
    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      // body: keranjanglist.length < 1 ? _keranjangKosong() : _widgetKeranjang(),
      body: login
          ? keranjanglist.length < 1
              ? _keranjangKosong()
              : _widgetKeranjang()
          : LoginPage(),
      bottomNavigationBar: Visibility(
        visible: login
            ? keranjanglist.isEmpty
                ? false
                : true
            : false,
        child: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total", style: TextStyle(fontSize: 14)),
                        Text(
                            "Rp. " +
                                NumberFormat.currency(
                                        locale: 'ID',
                                        symbol: "",
                                        decimalDigits: 0)
                                    .format(_subtotal)
                                    .toString(),
                            style: TextStyle(color: Colors.red, fontSize: 18))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      login
                          ? _klikCheckout(keranjanglist)
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    },
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Check Out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 70,
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _keranjangKosong() {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? keranjanglist.isEmpty
                ? SafeArea(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text("Keranjang Kosong",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _widgetKeranjang() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Keranjang>>(
              future: getKeranjang(),
              builder: (c, s) {
                if (!s.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return ListView.builder(
                    itemCount: s.data.length,
                    itemBuilder: (c, i) {
                      return Container(
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300],
                              width: 1,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.white, spreadRadius: 1),
                          ],
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(10),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://${sUrl}/storage' +
                                    "/" +
                                    s.data[i].foto,
                                height: 110,
                                width: 110,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s.data[i].nama,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          s.data[i].harga.toString(),
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red),
                                        ),
                                        // Text(
                                        //   " /" + s.data[i].satuan,
                                        //   style: TextStyle(
                                        //     fontSize: 14,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 100,
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (s.data[i].jumlah > 1) {
                                                    _kurangJmlhKeranjang(
                                                        s.data[i].id);
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.green,
                                                  size: 22,
                                                ),
                                              ),
                                              Text(
                                                s.data[i].jumlah.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _tambahJmlhKeranjang(
                                                      s.data[i].id);
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.green,
                                                  size: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 7, 10, 5),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  _deleteKeranjang(
                                                      s.data[i].id);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.red),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.red,
                                                        spreadRadius: 1,
                                                      )
                                                    ],
                                                  ),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      );
                    });
              },
            )),
          ],
        ),
      ),
    );
  }
}
