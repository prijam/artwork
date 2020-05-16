import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  final FirebaseUser firebaseUser;

  Upload({this.firebaseUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  var customPhoto = Image.asset("img/upload.gif");
  String _title = "";
  String _desc = "";
  String _contact = "";
  String _price = "";
  File _image;
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController con = TextEditingController();
  TextEditingController rate = TextEditingController();

  Future _saveCard(BuildContext context) async {
    if (_image != null) {
      _scaffoldState.currentState.showSnackBar(wait());
      String fileName = basename(_image.path);
      StorageReference fireBaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = fireBaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid)
          .collection("User_Data")
          .document("Upload")
          .collection("Collection")
          .document()
          .setData({
            "title": _title,
            "description": _desc,
            "price": _price,
            "contacNumber": _contact,
            "itemImage": downloadUrl,
            "photoUrlFile": fileName,
          })
          .whenComplete(() =>
              Firestore.instance.collection("userupload").document().setData({
                "title": _title,
                "description": _desc,
                "price": _price,
                "contacNumber": _contact,
                "itemImage": downloadUrl,
                "photoUrlFile": fileName,
              }))
          .whenComplete(() => Navigator.of(context).pop());
    } else {
      _scaffoldState.currentState.showSnackBar(noPhoto());
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _image = image;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Upload",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 900,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                        height: 200,
                        child: _image != null
                            ? Image.file(_image)
                            : (_image == null && customPhoto != null)
                                ? Image.asset(
                                    "img/upload.gif",
                                    filterQuality: FilterQuality.high,
                                  )
                                : Image.asset(
                                    "img/upload.gif",
                                    filterQuality: FilterQuality.high,
                                  )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 160,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: RaisedButton(
                      color: Colors.grey.withOpacity(0.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.image,
                            color: Colors.green,
                          ),
                          Text(
                            "Pick image",
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.6)),
                          )
                        ],
                      ),
                      elevation: 0.0,
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                imageName(),
                SizedBox(
                  height: 20,
                ),
                desc(),
                SizedBox(
                  height: 20,
                ),
                contact(),
                SizedBox(
                  height: 20,
                ),
                price(),
                SizedBox(
                  height: 20,
                ),
                upbtn(context)
              ],
            ),
          ),
        ));
  }

  Widget desc() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            controller: des,
            onChanged: (value) {
              _desc = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.3),
                ))));
  }

  Widget imageName() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            controller: title,
            onChanged: (value) {
              _title = value;
            },
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.title,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.3),
                ))));
  }

  Widget contact() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            controller: con,
            onChanged: (value) {
              _contact = value;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                hintText: "Contact",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.3),
                ))));
  }

  Widget price() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            controller: rate,
            onChanged: (value) {
              _price = value;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                hintText: "Price",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.monetization_on,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.3),
                ))));
  }

  Widget upbtn(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        height: 40,
        width: 120,
        child: RaisedButton(
          onPressed: () {
            _saveCard(context);
            Future.delayed(Duration(seconds: 3), () {
              title.clear();
              des.clear();
              rate.clear();
              con.clear();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                tag: 'fab',
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.green.withOpacity(0.9),
                ),
              ),
              Text(
                "upload",
                style: TextStyle(
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.grey.withOpacity(0.7)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget noPhoto() {
    return SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.photo,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("No Photo Selected"),
          )
        ],
      ),
    );
  }
  Widget wait() {
    return SnackBar(
      backgroundColor: Colors.orangeAccent,
      duration: Duration(seconds: 15),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.collections,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Uploading..."),
          )
        ],
      ),
    );
  }
}
