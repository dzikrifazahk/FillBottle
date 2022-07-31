// ignore_for_file: prefer_const_constructors

import 'package:fill_bottle/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fill_bottle/detail/komponent/body.dart';
import 'package:fill_bottle/detail/komponent/build_bottom_app_bar.dart';
import 'package:fill_bottle/helper/dbhelper.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/landing_page.dart';
import 'package:fill_bottle/model/keranjang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class ProdukDetailPage extends StatefulWidget {
  final Widget child;
  final int id, harga, jumlah, userid;
  final String nama, deskripsi, foto;

  const ProdukDetailPage({
    Key key,
    this.child,
    this.userid,
    this.id,
    this.nama,
    this.harga,
    this.foto,
    this.deskripsi,
    this.jumlah,
  }) : super(key: key);
  @override
  State<ProdukDetailPage> createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  String iUrl = Uri.http(sUrl, "/api/product").toString();
  String userid = "";
  bool login = false;
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getInt('id').toString() ?? 0;
    });
  }

  saveKeranjang(Keranjang _keranjang) async {
    // Database db = await dbHelper.database;
    // var cek = await db.query('keranjang');
    // print(cek);
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute(
        'insert into keranjang(idproduk,userid,nama,deskripsi,harga,foto,jumlah) values(?,?,?,?,?,?,?)',
        [
          _keranjang.idproduk,
          _keranjang.userid,
          _keranjang.nama,
          _keranjang.deskripsi,
          _keranjang.harga,
          _keranjang.foto,
          _keranjang.jumlah,
        ]);
    await batch.commit();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/keranjangusers', (route) => false);
  }

  saveKeranjangPref() async {
    print(widget.userid);
    var params = "http://" + sUrl + "/api/simpanKeranjang";
    // var url = Uri.http(sUrl, params, {"user_id": 2, "product_id": 1});
    var res = await http.post(Uri.parse(params),
        body: {"user_id": widget.userid, "product_id": widget.id});
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Produk",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 80,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Body(
                  judul: widget.nama,
                  deskripsi: widget.deskripsi,
                  harga: widget.harga.toString(),
                  url: 'http://${sUrl}/storage' + "/" + widget.foto,
                  press: () {
                    //klikFavorite(widget.id.toString(), userid);
                  },
                  // satuan: widget.satuan,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BuildBottomAppBar(
        pressB: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/keranjangusers', (Route<dynamic> route) => false);
        },
        pressK: () {
          if (login) {
            Keranjang _keranjangku = Keranjang(
              idproduk: widget.id,
              nama: widget.nama,
              harga: widget.harga,
              foto: widget.foto,
              jumlah: 1,
              userid: widget.userid,
              deskripsi: widget.deskripsi,
              // satuan: "Liter"
            );
            saveKeranjang(_keranjangku);
          } else {
            Navigator.pushNamed(context, '/profileusers');
          }
        },
        // instok: true,
      ),
    );
  }
}
