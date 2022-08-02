// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'package:fill_bottle/transaksi/komponent/detail_transaksi.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final dynamic transaksi;
  const ItemList({Key key, this.transaksi}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailTransaksi(transaksi: widget.transaksi)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset.zero,
            ),
          ],
        ),
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 25,
                  width: 60,
                  decoration: BoxDecoration(
                    color: widget.transaksi['status'] == "0"
                        ? Colors.blue
                        : widget.transaksi['status'] == "1"
                            ? Colors.teal
                            : widget.transaksi['status'] == "2"
                                ? Colors.green
                                : Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.transaksi['status'] == "0"
                          ? "proses"
                          : widget.transaksi['status'] == "1"
                              ? "di antar"
                              : widget.transaksi['status'] == "2"
                                  ? "selesai"
                                  : "cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Nota : " + widget.transaksi['kode']),
                            Text("Tanggal : " + widget.transaksi['tanggal']),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
