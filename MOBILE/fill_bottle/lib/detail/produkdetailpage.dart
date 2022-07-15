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
  final int id;
  final String judul, harga, hargax, thumbnail, deskripsi, satuan;
  final bool valstok;

  const ProdukDetailPage(this.id, this.judul, this.harga, this.hargax,
      this.thumbnail, this.deskripsi, this.valstok, this.satuan,
      {Key key, this.child})
      : super(key: key);
  @override
  State<ProdukDetailPage> createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  // List<Cabang> cabangList = [];
  // String _valcabang;
  bool instok = false;
  String iUrl = Uri.http(sUrl, "/CodeIgniter3").toString();
  String userid = "";
  DbHelper dbHelper = DbHelper();
  bool fav = false;

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
        'insert into keranjang(idproduk,judul,harga,hargax,thumbnail,jumlah,userid,idcabang,satuan) values(?,?,?,?,?,?,?,?,?)',
        [
          _keranjang.idproduk,
          _keranjang.judul,
          _keranjang.harga,
          _keranjang.hargax,
          _keranjang.thumbnail,
          _keranjang.jumlah,
          _keranjang.userid,
          _keranjang.idcabang,
          _keranjang.satuan
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
          "Detail Informasi",
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Body(
                  judul: widget.judul,
                  deskripsi: widget.deskripsi,
                  harga: widget.harga,
                  url: iUrl + "/" + widget.thumbnail,
                  fav: fav,
                  press: () {
                    //klikFavorite(widget.id.toString(), userid);
                  },
                  satuan: widget.satuan,
                ),
                // Container(
                //   margin: EdgeInsets.all(10),
                //   child: DropdownButtonFormField(
                //     decoration: InputDecoration(
                //       contentPadding:
                //           EdgeInsets.only(top: 10, bottom: 10, left: 12),
                //       border: OutlineInputBorder(
                //         borderRadius:
                //             BorderRadius.all(const Radius.circular(10)),
                //         borderSide: BorderSide(color: Colors.black, width: 1),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius:
                //             BorderRadius.all(const Radius.circular(10)),
                //         borderSide: BorderSide(color: Colors.black, width: 1),
                //       ),
                //       fillColor: Colors.black,
                //       filled: false,
                //     ),
                //     hint: Text("Pilih Cabang"),
                //     value: _valcabang,
                //     items: cabangList.map((item) {
                //       return DropdownMenuItem(
                //         child: Text(item.nama.toString()),
                //         value: item.id.toString(),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         _valcabang = value;
                //         _cekProdukCabang(widget.id.toString(), _valcabang);
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BuildBottomAppBar(
        pressK: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/keranjangusers', (Route<dynamic> route) => false);
        },
        pressB: () {
          if (true == true) {
            Keranjang _keranjangku = Keranjang(
                idproduk: widget.id,
                judul: widget.judul,
                harga: widget.harga,
                hargax: widget.hargax,
                thumbnail: widget.thumbnail,
                jumlah: 1,
                userid: userid,
                idcabang: "1",
                satuan: "Liter");
            saveKeranjang(_keranjangku);
          }
        },
        instok: true,
      ),
    );
  }
}
