// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TemukanPage extends StatefulWidget {
  const TemukanPage({Key key}) : super(key: key);

  @override
  _TemukanPageState createState() => _TemukanPageState();
}

class _TemukanPageState extends State<TemukanPage> {
  WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Toko Kami"),
        backgroundColor: Colors.blue,
      ),
      body: WillPopScope(
        onWillPop: () => _goBack(context),
        child: WebView(
          initialUrl:
              "https://www.google.com/maps/place/Indramayu+State+Polytechnic/@-6.4128062,108.2725494,14.38z/data=!4m5!3m4!1s0x2e6eb87d1fcaf97d:0x4fc15b3c8407ada4!8m2!3d-6.4084147!4d108.2814517",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          },
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return null;
    }
  }
}
