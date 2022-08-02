// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fill_bottle/detail/komponent/build_image.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  final String judul, harga, deskripsi, url, satuan;
  final Function press;
  const Body(
      {Key key,
      this.judul,
      this.harga,
      this.deskripsi,
      this.url,
      this.press,
      this.satuan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          BuildImage(
            url: url,
            press: press,
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  // 'RP ' + harga,
                  FormatCurrency.convertToIdr(int.parse(harga), 0),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  " / ml",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Produk',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              judul,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: 7.0),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              deskripsi,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Divider(
            color: Colors.black,
            height: 2.5,
            thickness: 0,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 32),
            child: Text(
              'Pesan ' + judul+' dengan ukuran per'+' ml',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Divider(
            color: Colors.black,
            height: 2.5,
            thickness: 0,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}

class FormatCurrency {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
