// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fill_bottle/detail/komponent/body.dart';
import 'package:fill_bottle/detail/komponent/build_bottom_app_bar.dart';
import 'package:fill_bottle/helper/dbhelper.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/landing_page.dart';
import 'package:fill_bottle/model/keranjang.dart';
import 'package:sqflite/sqflite.dart';

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
  // List<Cabang> cabangList = [];
  // String _valcabang;
  // bool instok = false;
  String iUrl = Uri.http(sUrl, "/api/product").toString();
  String userid = "";
  DbHelper dbHelper = DbHelper();
  // bool fav = false;

  @override
  void initState() {
    super.initState();
    // fetchCabang();
    // if (widget.valstok == true) {
    //   instok = widget.valstok;
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  saveKeranjang(Keranjang _keranjang) async {
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

  // Future<List<Cabang>> fetchCabang() async {
  //   List<Cabang> usersList;
  //   var params = "/CodeIgniter3/cabang";
  //   var url = Uri.http(sUrl, params);
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //       usersList = items.map<Cabang>((json) {
  //         return Cabang.fromJson(json);
  //       }).toList();
  //       setState(() {
  //         cabangList = usersList;
  //       });
  //     }
  //   } catch (e) {
  //     usersList = cabangList;
  //   }
  //   return usersList;
  // }

  // _cekProdukCabang(String idproduk, String idcabang) async {
  //   var params = "/CodeIgniter3/cekprodukbycabang";
  //   var url =
  //       Uri.http(sUrl, params, {"idproduk": idproduk, "idcabang": idcabang});
  //   try {
  //     var res = await http.get(url);
  //     if (res.statusCode == 200) {
  //       if (res.body == "OK") {
  //         setState(() {
  //           instok = true;
  //         });
  //       } else {
  //         setState(() {
  //           instok = false;
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     setState(() {
  //       instok = false;
  //     });
  //   }
  // }

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
                  url: 'https://fillbottle.nataysa.com/storage' +
                      "/" +
                      widget.foto,
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
          if (true == true) {
            Keranjang _keranjangku = Keranjang(
              idproduk: widget.id,
              nama: widget.nama,
              harga: widget.harga,
              foto: widget.foto,
              jumlah: 1,
              // userid: widget.userid,
              deskripsi: widget.deskripsi,
              // satuan: "Liter"
            );
            // print(widget.deskripsi);
            saveKeranjang(_keranjangku);
          }
        },
        // instok: true,
      ),
    );
  }
}
