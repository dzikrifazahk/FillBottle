// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'dart:ui';
import 'package:fill_bottle/model/keranjang.dart';
import 'package:flutter/material.dart';
import 'package:fill_bottle/scanner_page.dart';
import 'package:fill_bottle/detail/produkdetailpage.dart';
import 'package:fill_bottle/home/komponents/build_button.dart';
import 'package:fill_bottle/home/komponents/build_slider.dart';
import 'package:fill_bottle/home/komponents/carousel_slider.dart';
import 'package:fill_bottle/home/komponents/widget_by_kategori.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/maps_page.dart';
import 'package:fill_bottle/model/kategori.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fill_bottle/model/produk.dart';
import 'package:fill_bottle/temukan_page.dart';
import 'package:fill_bottle/scanner_page.dart';

class HomePage extends StatefulWidget {
  final String nama;
  const HomePage({Key key, this.nama}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Kategori> kategorilist = [];
  List<Produk> produkList = [];
  bool login = false;
  String userid;
  String nama;
  String level;
  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getString('email') ?? "";
      nama = prefs.getString('name') ?? "";
      level = prefs.getString('level') ?? "";
    });
  }

  Future<List<Produk>> fetchProduk() async {
    List<Produk> usersList;
    var params = "/api/product";
    var url = Uri.http(sUrl, params);
    try {
      var response = await http.get(url);
      // print(json.decode(response.body));
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Produk>((json) {
          return Produk.fromJson(json);
        }).toList();
        setState(() {
          produkList = usersList;
        });
      }
    } catch (e) {
      usersList = produkList;
    }
    return usersList;
    // print(usersList);
  }

  Icon icon = Icon(
    Icons.search,
    color: Color.fromARGB(255, 159, 94, 238),
  );

  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  bool _isSearchingAppBar = false;
  List<Produk> searchresult = [];

  _HomePageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  @override
  void initState() {
    super.initState();
    fetchProduk();
    _isSearching = false;
    fetchKategori();
    cekLogin();
  }

  Future<List<Kategori>> fetchKategori() async {
    List<Kategori> usersList;
    var params = "/CodeIgniter3/kategoribyproduk";
    var url = Uri.http(sUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Kategori>((json) {
          return Kategori.fromJson(json);
        }).toList();
        setState(() {
          kategorilist = usersList;
        });
      }
    } catch (e) {
      usersList = kategorilist;
    }
    return usersList;
  }

  Future<void> _refresh() {
    return fetchProduk().then((_kategori) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearchingAppBar || _controller.text != "" ?  BuildAppBar(context): null,
      body: _isSearching || _controller.text != ""
          ? SedangSearching(context)
          : TidakSearching(),
    );
  }

  RefreshIndicator SedangSearching(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(bottom: 7),
        child: FutureBuilder<List<Produk>>(
          future: fetchProduk(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemCount: searchresult.length,
              itemBuilder: (context, i) => Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => ProdukDetailPage(
                          id: searchresult[i].id,
                          nama: searchresult[i].nama,
                          foto: searchresult[i].foto,
                          harga: int.parse(searchresult[i].harga),
                          deskripsi: searchresult[i].deskripsi,
                          // false,
                          // searchresult[i].deskripsi,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        'https://fillbottle.nataysa.com/storage' +
                      "/" +
                      searchresult[i].foto,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          alignment: Alignment.topLeft,
                          child: Text(searchresult[i].nama)),
                      Container(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            searchresult[i].harga,
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  TidakSearching() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder (future: getName(),builder: (context, AsyncSnapshot snapshot) {
                        return Text('Hello, ${snapshot.data ?? ""}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 69, 71, 157),
                              fontWeight: FontWeight.bold),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Let's Fill",
                          style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 69, 71, 157),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: new Icon(
                    Icons.account_circle_rounded,
                    size: 50,
                    color: Color.fromARGB(255, 163, 165, 241),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            BuildSearch(context),
            SizedBox(height: 10),
            CarouselSliderPage(),
            SizedBox(height: 10),
            BuildSlider(),
            SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Semua Produk",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
            AllProduct(context),
          ],
        ),
      ),
    );
  }

  Widget AllProduct(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, i) => Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProdukDetailPage(
                          id: produkList[i].id,
                          nama: produkList[i].nama,
                          harga: int.parse(produkList[i].harga),
                          foto: produkList[i].foto,
                          deskripsi: produkList[i].deskripsi,
                        )),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://fillbottle.nataysa.com/storage' +
                            '/' +
                            produkList[i].foto),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    produkList[i].nama ?? "No Title",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: produkList.length,
      ),
    );
  }

  Widget BuildSearch(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 163, 165, 241),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              hintText: "Temukan kunjungan anda",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white70,
              )),
        ),
      ),
    );
  }

 Widget BuildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 159, 94, 238),
      title: GestureDetector(
        child: InkWell(
          onTap: () {
            setState(() {
              if (icon.icon == Icons.search) {
                icon = Icon(
                  Icons.close,
                  color: Colors.blue,
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _controller,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,

                suffixIcon: icon,
                hintText: "Search ",
                //hintStyle: TextStyle(color: Colors.white),
              ),
              onChanged: searchOperation,
            ),
          ),
        ),
      ),
    );
  }


  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      icon = Icon(
        Icons.search,
        color: Colors.blue,
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (var data in produkList) {
        if (data.nama.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
