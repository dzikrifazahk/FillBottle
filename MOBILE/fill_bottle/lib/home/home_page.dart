// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fill_bottle/bookmark_page.dart';
import 'package:fill_bottle/detail/produkdetailpage.dart';
import 'package:fill_bottle/home/komponents/build_button.dart';
import 'package:fill_bottle/home/komponents/build_slider.dart';
import 'package:fill_bottle/home/komponents/widget_by_kategori.dart';
import 'package:fill_bottle/konstant.dart';
import 'package:fill_bottle/maps_page.dart';
import 'package:fill_bottle/model/kategori.dart';
import 'package:http/http.dart' as http;
import 'package:fill_bottle/model/produk.dart';
import 'package:fill_bottle/temukan_page.dart';
import 'package:fill_bottle/bookmark_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Kategori> kategorilist = [];
  List<Produk> produkList = [];
  String iUrl = Uri.http(sUrl, "/CodeIgniter3").toString();

  Future<List<Produk>> fetchProduk(
      String idkategori, String idsubkategori) async {
    List<Produk> usersList;
    var params = "/CodeIgniter3/produkbykategori";
    var url = Uri.http(sUrl, params,
        {"idkategori": idkategori, "idsubkategori": idsubkategori});
    try {
      var response = await http.get(url);
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
  }

  Icon icon = Icon(
    Icons.search,
    color: Color.fromARGB(255, 159, 94, 238),
  );

  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
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

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    fetchKategori();
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
    return fetchProduk("", "").then((_kategori) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
          future: fetchProduk("", ""),
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
                          searchresult[i].id,
                          searchresult[i].judul,
                          searchresult[i].harga,
                          searchresult[i].hargax,
                          searchresult[i].thumbnail,
                          searchresult[i].deskripsi,
                          false,
                          searchresult[i].satuan,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        iUrl + "/" + searchresult[i].thumbnail,
                        fit: BoxFit.fill,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          alignment: Alignment.topLeft,
                          child: Text(searchresult[i].judul)),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 30,
                ),
                child: Text(
                  "Hallo, Olivia",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 69, 71, 157),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 40),
                child: new Icon(
                  Icons.account_circle_rounded,
                  size: 50,
                  color: Color.fromARGB(255, 163, 165, 241),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          BuildSlider(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildButton(
                title: "Temukan Yang Menarik",
                icon: Icons.location_on,
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TemukanPage()));
                },
              ),
              SizedBox(
                width: 10,
              ),
              // BuildButton(
              //   title: "Voucher",
              //   icon: Icons.paid_sharp,
              //   press: () {
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => BookmarkPage()));
              //   },
              // )
              BuildButton(
                title: "Bookmark",
                icon: Icons.paid_sharp,
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BookmarkPage()));
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < kategorilist.length; i++)
                WidgetByKategori(
                    kategorilist[i].id, kategorilist[i].nama.toString(), i),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 163, 165, 241),
      automaticallyImplyLeading: false,
      title: GestureDetector(
        child: InkWell(
          onTap: () {
            setState(() {
              if (icon.icon == Icons.search) {
                icon = Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 163, 165, 241),
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
        if (data.judul.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
