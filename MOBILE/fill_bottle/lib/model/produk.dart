// To parse this JSON data, do
//
//     final produk = produkFromJson(jsonString);

import 'dart:convert';

List<Produk> produkFromJson(String str) =>
    List<Produk>.from(json.decode(str).map((x) => Produk.fromJson(x)));

String produkToJson(List<Produk> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Produk {
  Produk({
    this.id,
    this.partnerId,
    this.kode,
    this.nama,
    this.deskripsi,
    this.harga,
    this.foto,
    this.createdAt,
    this.updatedAt,
    this.partner,
  });

  int id;
  String partnerId;
  String kode;
  String nama;
  String deskripsi;
  String harga;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;
  Partner partner;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json["id"],
        partnerId: json["partner_id"],
        kode: json["kode"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        partner: Partner.fromJson(json["partner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partnerId,
        "kode": kode,
        "nama": nama,
        "deskripsi": deskripsi,
        "harga": harga,
        "foto": foto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "partner": partner.toJson(),
      };
}

class Partner {
  Partner({
    this.id,
    this.kode,
    this.nama,
    this.alamat,
    this.kota,
    this.provinsi,
    this.kodepos,
    this.telp,
    this.email,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  dynamic kode;
  String nama;
  String alamat;
  String kota;
  String provinsi;
  String kodepos;
  String telp;
  String email;
  String logo;
  DateTime createdAt;
  DateTime updatedAt;

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        alamat: json["alamat"],
        kota: json["kota"],
        provinsi: json["provinsi"],
        kodepos: json["kodepos"],
        telp: json["telp"],
        email: json["email"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "alamat": alamat,
        "kota": kota,
        "provinsi": provinsi,
        "kodepos": kodepos,
        "telp": telp,
        "email": email,
        "logo": logo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
