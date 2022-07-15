import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  static double nLat = -6.4004936;
  static double nLong = 108.2162669;
  dynamic gab;

  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    double a = -6.4004936;
    double b = 108.2162669;
    nLat = a;
    nLong = b;
  }

  static LatLng _center = LatLng(nLat, nLong);

  LatLng _lastPosition = _center;

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(nLat, nLong),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        //This marker id can be anything that uniquely identifier each marker.
        markerId: MarkerId(_lastPosition.toString()),
        position: _lastPosition,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Maps",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roboto', fontSize: 20),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 2000.0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                    ),
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: ListTile(
                  title: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nama',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          Text(
                            'KUTIKIN Store',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                          ),
                          Text(
                            'Buka',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          Text(
                            '09:30',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                          ),
                          Text(
                            'Tutup',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          Text(
                            '17:30',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                          ),
                          Text(
                            'Place',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          Text(
                            'Lohbener Indramayu',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Open Sans'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                height: 400,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: _kGooglePlex,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                      _onAddMarkerButtonPressed();
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
