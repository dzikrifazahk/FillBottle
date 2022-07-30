// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageWithIcon extends StatefulWidget {
  const ImageWithIcon({Key key}) : super(key: key);

  @override
  State<ImageWithIcon> createState() => _ImageWithIconState();
}

class _ImageWithIconState extends State<ImageWithIcon> {
  File image;

  Future openCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    image = File(pickedImage.path);
  }

  Future openGallery() async {
    final imageGallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(imageGallery.path);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.black12,
                child: ClipOval(
                  child: image == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 100,
                        )
                      : Image.file(
                          image,
                          //fit: BoxFit.cover,
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
