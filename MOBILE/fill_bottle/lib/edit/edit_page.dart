// ignore_for_file: missing_return, missing_required_param

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fill_bottle/edit/komponent/body.dart';
import 'package:fill_bottle/edit/komponent/build_text_field.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/model/pelanggan.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final String userid;
  const EditPage({Key key, this.userid}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<Pelanggan> pelangganList = [];
  TextEditingController nama, alamat, kota, provinsi, kodepos, telp, email;
  final _form = GlobalKey<FormState>();

  Future<List<Pelanggan>> fetchPelanggan(String id) async {
    List<Pelanggan> usersList;
    var params = "/CodeIgniter3/pelanggan";
    var url = Uri.http(sUrl, params, {"userid": id});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Pelanggan>((json) {
          return Pelanggan.fromJson(json);
        }).toList();
        setState(() {
          pelangganList = usersList;
        });
      }
    } catch (e) {
      usersList = pelangganList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: FutureBuilder<List<Pelanggan>>(
          future: fetchPelanggan(widget.userid),
          builder: (context, s) {
            if (!s.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            for (int i = 0; i < s.data.length; i++) {
              return Body(
                  nama: pelangganList[i].nama,
                  alamat: pelangganList[i].alamat,
                  telp: pelangganList[i].telp,
                  kota: pelangganList[i].kota,
                  kodepos: pelangganList[i].kodepos,
                  provinsi: pelangganList[i].provinsi,
                  email: pelangganList[i].email);
            }
          }),
    );
  }
}
