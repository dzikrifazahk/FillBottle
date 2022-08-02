import 'dart:convert';

import 'package:fill_bottle/konstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailTransaksi extends StatefulWidget {
  final dynamic transaksi;
  const DetailTransaksi({Key key, this.transaksi}) : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  getDetailTransaksi() async {
    var params =
        "/api/showDetailTransaction/" + widget.transaksi['id'].toString();
    var url = Uri.http(sUrl, params);
    var response = await http.get(url);
    return json.decode(response.body);
  }

  getProduk(String id) async {
    var params = "/api/product/" + id;
    var url = Uri.http(sUrl, params);
    var response = await http.get(url);
    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Detail Transaksi ${widget.transaksi['kode']}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Table(
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "Kode",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.transaksi['kode'],
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "Nama Pemesan",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.transaksi['user']['name'],
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "Tanggal Pemesanan",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.transaksi['tanggal'],
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "Total",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.transaksi['total'],
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "Metode Pembayaran",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.transaksi['metode'] == 1 ? "COD" : 'Transfer',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      height: 30,
                      child: Text(
                        "Status Pemesanan",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.transaksi['status'] == "0"
                            ? "proses"
                            : widget.transaksi['status'] == "1"
                                ? "di antar"
                                : widget.transaksi['status'] == "2"
                                    ? "selesai"
                                    : "cancel",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ]),
                ],
              ),
              Column(
                children: [
                  Expanded(
                      child: Container(
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
                            'https://${sUrl}/storage/uploads/images/2022-08-02/1659411387/foto_2022-08-02.jpg',
                            height: 110,
                            width: 110,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "as",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "12",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.green,
                                              size: 22,
                                            ),
                                          ),
                                          Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 7, 10, 5),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
