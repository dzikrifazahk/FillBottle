import 'package:flutter/material.dart';
import 'package:fill_bottle/edit/komponent/build_text_field.dart';

class Body extends StatefulWidget {
  final String nama, alamat, kota, provinsi, kodepos, telp, email;
  const Body({
    Key key,
    @required GlobalKey<FormState> form,
    @required this.nama,
    @required this.alamat,
    @required this.kota,
    @required this.provinsi,
    @required this.kodepos,
    @required this.telp,
    @required this.email,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> _form;
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
    nama.text = widget.nama;
    alamat.text = widget.alamat;
    kota.text = widget.kota;
    provinsi.text = widget.provinsi;
    kodepos.text = widget.kodepos;
    telp.text = widget.telp;
    email.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            BuildTextField(
              control: nama,
              icon: Icons.person,
              input: TextInputType.name,
              hint: "Hanya Contoh",
              label: "Nama Lengkap",
              validasi: (text) {
                if (text == null || text.isEmpty) {
                  return 'Nama cannot be empty';
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
                  return 'Telephone cannot be empty';
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
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    final isValid = _form.currentState.validate();
                    if (!isValid) {
                      return;
                    } else {
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //         builder: (context) => LandingPage()));
                      //_login();
                    }
                  },
                  child: Text('Simpan',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 2,
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
