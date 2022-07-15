import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fill_bottle/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  static const url = "https://wa.me/?text=YourTextHere";

  openwhatsapp() async {
    var whatsapp = "+6289639490563";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Panduan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, top: 25, bottom: 20),
              color: Colors.grey[350],
              child: Text(
                'Panduan',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 25),
              child: Text(
                '1. Buka Aplikasi',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            // konten 1
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53),
              child: Text(
                'Buka aplikasi KUTIK-IN yang telah dipasang pada gadget anda.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                '2. Daftar Akun',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            //konten 2
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53),
              child: Text(
                'Untuk daftar akun bisa masuk kedalam halaman daftar pada halaman profile.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                '3. Masuk Akun',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),

            //konten 3
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Untuk masuk akun bisa masuk kedalam halaman pada halaman profile dan masukkan no telpon dan password yang telah didaftarkan pada aplikasi.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                '4. Menu Transaksi',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 30),
              child: Text(
                'Pada transaksi terdapat 2 Tab Bar dimana terdiri dari keranjang saya, status transaksi dan 1 fitur pembayaran, dimana 3 fitur ini dapat digunakan untuk melakukan transaksi, sebelum melakukan transaksi pastikan alamat tujuan benar.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            //4.1
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53),
              child: Text(
                '4.1 Keranjang Saya',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Pada menu keranjang ini pengguna dapat melihat produk - produk yang akan dipesan oleh pengguna sebelum melakukan pembayaran.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            //4.2
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53),
              child: Text(
                '4.2 Menu Status',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Pada menu status ini pengguna dapat melihat status dari produk - produk yang telah dipesan dan telah melakukan pembayaran pada pesananya.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                '5. Menu Pembayaran',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Pada menu pembayaran ini pengguna dapat melakukan pembayaran terhadap produk pesananya.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                '6. Menu Profile',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Pada menu profile ini pengguna dapat melakukan pengaturan terhadap profilenya dan beberapa bantuan mengenai aplikasi.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                '6.1 Pengaturan Profile',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Pada pengaturan profile ini pengguna dapat melakukan perubahan pada data data yang memuat dari pengguna itu sendiri.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                '6.2 Halaman Tutorial',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Pada tutorial ini pengguna melihat panduan penggunaan aplikasi KUTIK-IN.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                '6.3 Pusat Bantuan',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                'Tombol pusat bantuan ini akan mengalihkan ke aplikasi telpon yang ada pada gadget anda dan anda pun dapat menghubungi customer service kami untuk berbagai keluhan yang anda alami terhadap aplikasi.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15),
              child: Text(
                '6.4 Logout',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 53, right: 15, bottom: 70),
              child: Text(
                'Tombol logout ini digunakan untuk mengeluarkan akun dari aplikasi KUTIK-IN.',
                style: TextStyle(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.whatsapp_outlined),
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
        onPressed: () {
          setState(() {
            openwhatsapp();
          });
        },
      ),
    );
    // body:     ;
  }
}
