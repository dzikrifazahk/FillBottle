import 'dart:io';
import 'package:fill_bottle/model/keranjang.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper ??= DbHelper._createObject();
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'laravel.db';

    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE keranjang(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idproduk INTEGER NULL,
        partnerId INTEGER,
        userid INTEGER,
        kode INTEGER,
        nama TEXT,
        deskripsi TEXT, 
        harga INTEGER,
        foto TEXT,
        partner TEXT,
        jumlah INTEGER
      );
    ''');
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database;
  }

  Future<List<Map<String, dynamic>>> selectKeranjang() async {
    Database db = await database;
    var mapList = await db.query('keranjang');
    return mapList;
  }

  Future<List<Keranjang>> getKeranjang(int userId) async {
    var mapList = await selectKeranjang();
    int count = mapList.length;
    List<Keranjang> list = <Keranjang>[];
    print(mapList);
    for (int i = 0; i < count; i++) {
      if (Keranjang.fromMap(mapList[i]).userid == userId) {
        list.add(Keranjang.fromMap(mapList[i]));
      } else {
        list = [];
      }
    }
    return list;
  }
}
