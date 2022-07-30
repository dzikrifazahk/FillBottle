// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fill_bottle/transaksi/keranjang_page.dart';
import 'package:fill_bottle/transaksi/status_page.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key key}) : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Color.fromARGB(255, 242, 238, 238),
          labelPadding: EdgeInsets.all(0),
          tabs: [
            Tab(text: "KERANJANG"),
            Tab(text: "STATUS"),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          KeranjangPage(),
          StatusPage(),
        ],
      ),
    );
  }
}
