// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:fill_bottle/konstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageWithIcon extends StatefulWidget {
  final int userid;
  final String kode;
  final String image;
  const ImageWithIcon({Key key, this.userid, this.kode, this.image})
      : super(key: key);

  @override
  State<ImageWithIcon> createState() => _ImageWithIconState();
}

class _ImageWithIconState extends State<ImageWithIcon> {
  File image;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  Future openCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
      await postImage(image);
    }
  }

  Future openGallery() async {
    final imageGallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      setState(() {
        image = File(imageGallery.path);
      });
      await postImage(image);
    }
  }

  Future postImage(File image) async {
    String url =
        'http://' + sUrl + '/api/editCustomer/' + widget.userid.toString();
    var request = http.MultipartRequest('post', Uri.parse(url))
      ..fields.addAll({
        'kode': widget.kode,
      })
      ..files.add(await http.MultipartFile.fromPath('foto', image.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Update Sukses"),
      ));
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.black12,
                child: ClipOval(
                  child: image == null
                      ? widget.image == null
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 100,
                            )
                          : Image.network(
                              'http://' + sUrl + '/storage/' + widget.image,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            )
                      : Image.file(
                          image,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Choose Profile Photo",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FlatButton.icon(
                                        icon: Icon(Icons.camera),
                                        onPressed: () {
                                          openCamera();
                                          Navigator.pop(context);
                                        },
                                        label: Text("Camera"),
                                      ),
                                      FlatButton.icon(
                                        icon: Icon(Icons.image),
                                        onPressed: () {
                                          openGallery();
                                          Navigator.pop(context);
                                        },
                                        label: Text("Gallery"),
                                      )
                                    ],
                                  )
                                ],
                              ))));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 159, 94, 238),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
