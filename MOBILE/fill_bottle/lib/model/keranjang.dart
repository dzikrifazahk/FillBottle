import 'dart:ffi';

class Keranjang {
  final int id;
  final int partnerId;
  final String kode;
  final String nama;
  final String deskripsi;
  final int harga;
  final String foto;
  final String partner;
  final int idproduk;
  final int jumlah;
  final int userid;

  Keranjang({
    this.id,
    this.partnerId,
    this.kode,
    this.nama,
    this.deskripsi,
    this.harga,
    this.foto,
    this.partner,
    this.idproduk,
    this.jumlah,
    this.userid,
  });

  factory Keranjang.fromJson(Map<String, dynamic> json) {
    return Keranjang(
      id: json['id'] as int,
      partnerId: json['partnerId'] as int,
      kode: json['kode'] as String,
      nama: json['harga'] as String,
      deskripsi: json['deskripsi'] as String,
      harga: json['harga'] as int,
      foto: json['foto'] as String,
      partner: json['partner'] as String,
      idproduk: json['idproduk'] as int,
      jumlah: json['jumlah'] as int,
      userid: json['userid'] as int
    );
  }

  factory Keranjang.fromMap(Map<String, dynamic> map) {
    return Keranjang(
      id: map['id'] as int,
      partnerId: map['partnerId'] as int,
      kode: map['kode'] as String,
      nama: map['harga'] as String,
      deskripsi: map['deskripsi'] as String,
      harga: map['harga'] as int,
      foto: map['foto'] as String,
      partner: map['partner'] as String,
      idproduk: map['idproduk'] as int,
      jumlah: map['jumlah'] as int,
      userid: map['userid'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['partnerId'] = partnerId;
    map['kode'] = kode;
    map['harga'] = harga;
    map['deskripsi'] = deskripsi;
    map['harga'] = harga;
    map['foto'] = foto;
    map['partner'] = partner;
    map['idproduk'] = idproduk;
    map['jumlah'] = jumlah;
    map['jumlah'] = userid;
    return map;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "partnerId": partnerId,
        "kode": kode,
        "harga": harga,
        "nama": nama,
        "deskripsi": deskripsi,
        "harga": harga,
        "foto": foto,
        "partner": partner,
        "idproduk": idproduk,
        "jumlah": jumlah,
        "userid": userid,
      };
}
