import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'landing_page.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 234, 250),
        appBar: AppBar(
            title: Text(
              "My Bookmarks",
              style: TextStyle(
                  color: Color.fromARGB(255, 68, 72, 174),
                  fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            backgroundColor: Color.fromARGB(255, 235, 234, 250),
            elevation: 0,
            actions: [
              IconButton(
                  icon: new Icon(Icons.more_horiz,
                      color: Color.fromARGB(255, 68, 72, 174))),
            ]),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            width: width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                FSearch(
                  height: 40.0,
                  cursorRadius: 7.0,
                  backgroundColor: Colors.white,
                  style: TextStyle(
                      fontSize: 16.0,
                      height: 1.0,
                      color: Color.fromARGB(255, 68, 72, 174)),
                  margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 9.0),
                  padding: EdgeInsets.only(
                      left: 6.0, right: 6.0, top: 3.0, bottom: 3.0),
                  prefixes: [
                    const SizedBox(width: 6.0),
                    Icon(
                      Icons.search,
                      size: 25,
                      color: Color.fromARGB(255, 194, 194, 194),
                    ),
                    const SizedBox(width: 3.0)
                  ],
                ),
                SizedBox(height: 20),
                BannerListTile(
                  imageContainerSize: 120,
                  onTap: () {},
                  // height: 150,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  showBanner: false,
                  imageContainer: Image(
                      image: AssetImage("assets/images/gedungsate.png"),
                      fit: BoxFit.fill),
                  title: const Text(
                    "Gedung Sate",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 60, 59, 59)),
                    maxLines: 1,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('Gedung Sate Merupakan '),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 68, 72, 174),
                      )),
                ),
                const SizedBox(height: 20),
                //
                BannerListTile(
                  imageContainerSize: 120,
                  onTap: () {},
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  bannerPositionRight: true,
                  borderRadius: BorderRadius.circular(20),
                  showBanner: false,
                  imageContainer: const Image(
                      image: AssetImage("assets/images/braga.png"),
                      fit: BoxFit.cover),
                  title: const Text(
                    "Braga City",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 60, 59, 59)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: const Text("Jalan Bersejarah di Bandung yang Indah",
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 60, 59, 59))),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 68, 72, 174),
                      )),
                ),
                //
                const SizedBox(height: 20),
                BannerListTile(
                  imageContainerSize: 120,
                  onTap: () {},
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  bannerPositionRight: true,
                  borderRadius: BorderRadius.circular(20),
                  showBanner: false,
                  imageContainer: const Image(
                      image: AssetImage("assets/images/geologi.png"),
                      fit: BoxFit.cover),
                  title: const Text(
                    "Museum Geologi",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 60, 59, 59)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: const Text(
                      "Museum yang Membawa Rasa Menyelam didalamnya",
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 60, 59, 59))),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 68, 72, 174),
                      )),
                ),
                const SizedBox(height: 20),
                //
                BannerListTile(
                  imageContainerSize: 120,
                  onTap: () {},
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  bannerPositionRight: true,
                  borderRadius: BorderRadius.circular(20),
                  showBanner: false,
                  imageContainer: const Image(
                      image: AssetImage("assets/images/braga.png"),
                      fit: BoxFit.cover),
                  title: const Text(
                    "Museum boscha",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 60, 59, 59)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: const Text("Museum yang Terkenal dengan keunikanya",
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 60, 59, 59))),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 68, 72, 174),
                      )),
                ),
                //
                const SizedBox(height: 20),
                //
                BannerListTile(
                  imageContainerSize: 120,
                  onTap: () {},
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  bannerPositionRight: true,
                  borderRadius: BorderRadius.circular(20),
                  showBanner: false,
                  imageContainer: const Image(
                      image: AssetImage("assets/images/gedungsate.png"),
                      fit: BoxFit.cover),
                  title: const Text(
                    "Museum Asia Afrika",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 60, 59, 59)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: const Text(
                      "Museum Konferensi Asia Afrika di Bandung",
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 60, 59, 59))),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 68, 72, 174),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
