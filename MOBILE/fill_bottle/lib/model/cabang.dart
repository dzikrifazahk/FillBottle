// To parse this JSON data, do
//
//     final cabang = cabangFromJson(jsonString);

import 'dart:convert';

List<Cabang> cabangFromJson(String str) => List<Cabang>.from(json.decode(str).map((x) => Cabang.fromJson(x)));

String cabangToJson(List<Cabang> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cabang {
    Cabang({
        this.id,
        this.nama,
        this.pimpinan,
        this.alamat,
        this.kota,
        this.provinsi,
        this.kodepos,
        this.foto,
        this.telp,
        this.email,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String nama;
    String pimpinan;
    String alamat;
    String kota;
    String provinsi;
    String kodepos;
    String foto;
    String telp;
    String email;
    DateTime createdAt;
    DateTime updatedAt;

    factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
        id: json["id"],
        nama: json["nama"],
        pimpinan: json["pimpinan"],
        alamat: json["alamat"],
        kota: json["kota"],
        provinsi: json["provinsi"],
        kodepos: json["kodepos"],
        foto: json["foto"],
        telp: json["telp"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "pimpinan": pimpinan,
        "alamat": alamat,
        "kota": kota,
        "provinsi": provinsi,
        "kodepos": kodepos,
        "foto": foto,
        "telp": telp,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
