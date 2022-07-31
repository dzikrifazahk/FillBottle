import 'dart:convert';

import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/profil/komponents/image_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fill_bottle/edit/komponent/build_text_field.dart';

class Body extends StatefulWidget {
  final String namaDepan,
      namaBelakang,
      alamat,
      kode,
      kota,
      provinsi,
      kodepos,
      telp,
      email,
      image;
  final int userid;
  const Body({
    Key key,
    @required GlobalKey<FormState> form,
    @required this.userid,
    @required this.namaDepan,
    @required this.namaBelakang,
    @required this.alamat,
    @required this.kode,
    @required this.kota,
    @required this.provinsi,
    @required this.kodepos,
    @required this.telp,
    @required this.email,
    @required this.image,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController namaDepan = TextEditingController();
  TextEditingController namaBelakang = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    namaDepan.text = widget.namaDepan;
    namaBelakang.text = widget.namaBelakang;
    alamat.text = widget.alamat;
    kota.text = widget.kota;
    provinsi.text = widget.provinsi;
    kodepos.text = widget.kodepos;
    telp.text = widget.telp;
    email.text = widget.email;
  }

  _postCustomer(BuildContext context) async {
    var params = "/api/editCustomer/" + widget.userid.toString();
    var url = Uri.http(sUrl, params, {
      "email": email.text,
      "name": namaDepan.text,
      "last_name": namaBelakang.text,
      "alamat": alamat.text,
      "kota": kota.text,
      "provinsi": provinsi.text,
      "kodepos": kodepos.text,
      "telp": telp.text,
    });
    var response = await http.post(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Update Sukses"),
      ));
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: ImageWithIcon(
                image: widget.image,
                kode: widget.kode,
                userid: widget.userid,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: namaDepan,
              icon: Icons.person,
              input: TextInputType.name,
              hint: "Hanya Contoh",
              label: "Nama Lengkap",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Nama depan harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: namaBelakang,
              icon: Icons.person,
              input: TextInputType.name,
              hint: "Hanya Contoh",
              label: "Nama Lengkap",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Nama belakang harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: alamat,
              icon: Icons.location_on,
              input: TextInputType.streetAddress,
              hint: "JL. Lohbener",
              label: "Alamat",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Alamat harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: kota,
              icon: Icons.location_city,
              input: TextInputType.text,
              hint: "Indramayu",
              label: "Kota",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Kota harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: provinsi,
              icon: Icons.business,
              input: TextInputType.text,
              hint: "Jawa Barat",
              label: "Provinsi",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Provinsi harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: kodepos,
              icon: Icons.local_post_office,
              input: TextInputType.number,
              hint: "123456",
              label: "Kode pos",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Kode pos harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: telp,
              icon: Icons.call,
              input: TextInputType.phone,
              hint: "089123456789",
              label: "Telephone",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Telepon harap diisi';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: email,
              icon: Icons.mail,
              input: TextInputType.emailAddress,
              hint: "contoh@example.com",
              label: "Email",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Email harap diisi';
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                height: 58,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_form.currentState.validate()) {
                      return;
                    }
                    _postCustomer(context);
                  },
                  child: Text('Simpan',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 2,
                      primary: Color.fromARGB(255, 163, 165, 241),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
