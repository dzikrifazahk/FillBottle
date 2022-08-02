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
              SizedBox(height: 20),
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                      future: getDetailTransaksi(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
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
                                    BoxShadow(
                                        color: Colors.white, spreadRadius: 1),
                                  ],
                                ),
                                child: ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.all(10),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        "https://${sUrl}/storage/${snapshot.data[index]['product']['foto']}",
                                        height: 110,
                                        width: 110,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index]['product']
                                                  ['nama'],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data[index]
                                                          ['product']['harga']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.red),
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
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
