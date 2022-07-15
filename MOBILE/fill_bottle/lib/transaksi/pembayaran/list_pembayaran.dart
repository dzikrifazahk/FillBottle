// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Voucher> list = <Voucher>[
      Voucher(title: "OVO", durasi: "2 Hari"),
      Voucher(title: "Dana", durasi: "2 Hari"),
      Voucher(title: "Voucher Diskon 10%", durasi: "2 Hari"),
      Voucher(title: "Voucher Diskon 10%", durasi: "2 Hari"),
      Voucher(title: "Voucher Diskon 10%", durasi: "2 Hari"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: Colors.blue,
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.paid_sharp),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list[i].title),
                    Text(list[i].durasi),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Voucher {
  Voucher({
    this.title,
    this.durasi,
  });

  String title;
  String durasi;
}
