// ignore_for_file: missing_return, missing_required_param

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fill_bottle/edit/komponent/body.dart';
import 'package:fill_bottle/edit/komponent/build_text_field.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/model/pelanggan.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final int userid;
  const EditPage({Key key, this.userid}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController namaDepan,
      namaBelakang,
      alamat,
      kota,
      provinsi,
      kodepos,
      telp,
      email;
  final _form = GlobalKey<FormState>();

  Future getData() async {
    var params = "/api/showCustomer/" + widget.userid.toString();
    var url = Uri.http(sUrl, params);
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, s) {
          if (!s.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Body(
              userid: widget.userid,
              namaDepan: s.data[0]['name'],
              namaBelakang: s.data[0]['last_name'],
              kode: s.data[0]['kode'],
              alamat: s.data[0]['customer']['alamat'],
              kota: s.data[0]['customer']['kota'],
              provinsi: s.data[0]['customer']['provinsi'],
              kodepos: s.data[0]['customer']['kodepos'],
              telp: s.data[0]['telp'],
              image: s.data[0]['customer']['foto'],
              email: s.data[0]['email']);
        },
      ),
    );
  }
}
