import 'dart:io';
import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/userModel.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  final FirebaseUser firebaseUser;

  Upload({this.firebaseUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  var customPhoto = Image.asset("img/upload.gif");
  File _image;
  var selectType;
  String _title = "";
  String _desc = "";
  String _contact = "";
  String _price = "";
  TextEditingController _pri = TextEditingController();
  TextEditingController _con = TextEditingController();
  TextEditingController titl1 = TextEditingController();
  TextEditingController des1 = TextEditingController();
  TextEditingController con1 = TextEditingController();
  TextEditingController rate1 = TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _image = image;
            }));
  }

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
            "itemType": selectType,
          })
          .whenComplete(() => Firestore.instance
                  .collection("userupload")
                  .document(selectType)
                  .collection("Uploads")
                  .document()
                  .setData({
                "title": _title,
                "description": _desc,
                "price": _price,
                "contacNumber": _contact,
                "itemImage": downloadUrl,
                "photoUrlFile": fileName,
              }))
          .whenComplete(() =>
              Firestore.instance.collection("explore").document().setData({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add details",
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w800),
        ),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
          )
        ],
//
//      ],
//
//      backgroundColor: Colors.white,
//      elevation: 0.0,
//      iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: 950,
          child: Column(
            children: <Widget>[
              title(),
              header(),
              ImageBox(),
              btn(context),
              des(),
              desBox(),
              Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Divider(
                    thickness: 0.5,
                  )),
              pric(),
              pri(),
              itemtype(),
              type(),
              contactNo(),
              con(),
              SizedBox(
                height: 30,
              ),
              upbtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: Container(
          color: Colors.white,
          child: new TextFormField(
              onChanged: (value) {
                _title = value;
              },
              cursorColor: Colors.red,
              cursorWidth: 2.0,
              controller: titl1,
              decoration: InputDecoration.collapsed(
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.grey.withOpacity(0.8),
                ),
                hintText: "Add a title",
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              )),
        ));
  }

//  Widget header() {
//    return Container(
//      margin: EdgeInsets.only(left: 12, top: 5),
//      child: Row(children: <Widget>[
//        InkWell(
//            onTap: () {},
//            child: StreamBuilder<User>(
//              stream: Auth.getUser(widget.firebaseUser.uid),
//              builder: (_, snapshot) {
//                return snapshot.hasData
//                    ? CircleAvatar(
//                  radius: 17.0,
//                  backgroundImage:
//                  NetworkImage(snapshot.data.profilePictureURL),
//                  backgroundColor: Colors.transparent,
//                )
//                    : Center(child: Container());
//              },
//            )),
//        Container(
//          width: 150,
//          height: 30,
//          child: StreamBuilder<User>(
//            stream: Auth.getUser(widget.firebaseUser.uid),
//            builder: (_, snapshot) {
//              return snapshot.hasData
//                  ? Padding(
//                padding: const EdgeInsets.only(top: 8.0),
//                child: Text(snapshot.data.firstName),
//              )
//                  : Center(child: Container());
//            },
//          ),
//        )
//      ]),
//    );
//  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: StreamBuilder<User>(
        stream: Auth.getUser(widget.firebaseUser.uid),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 17.0,
                      backgroundImage:
                          NetworkImage(snapshot.data.profilePictureURL),
                      backgroundColor: Colors.transparent,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, left: 15),
                      child: Text(
                        snapshot.data.firstName,
                        style: TextStyle(
                            color: Colors.blueAccent[400],
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )
              : Center(child: Container());
        },
      ),
    );
  }

  Widget ImageBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
              color: Colors.white,
              height: 200,
              width: 380,
              child: _image != null
                  ? Image.file(
                      _image,
                      fit: BoxFit.cover,
                    )
                  : (_image == null && customPhoto != null)
                      ? Image.asset(
                          "img/upload.gif",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "img/upload.gif",
                          filterQuality: FilterQuality.high,
                        ))),
    );
  }

  Widget btn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 60,
      width: 380,
      child: RaisedButton(
        elevation: 2.0,
        color: Colors.white,
        onPressed: () {
          getImage();
        },
        child: YourData(context),
      ),
    );
  }

  Widget YourData(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.photo_library,
          color: Colors.grey.withOpacity(0.6),
          size: 35.0,
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Image or GIF",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    fontFamily: 'font3',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "PNG, JPG, GIF",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      fontFamily: 'font3',
                      color: Colors.grey.withOpacity(0.78)),
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.blueGrey,
        )
      ],
    );
  }

  Widget pric() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 40,
      width: 380,
      child: Row(
        children: <Widget>[
          Text(
            "Price",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19.0),
          ),
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.monetization_on,
            color: Colors.grey.withOpacity(0.6),
          )
        ],
      ),
    );
  }

  Widget pri() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: new TextFormField(
          onChanged: (value) {
            _price = value;
          },
          cursorColor: Colors.red,
          controller: _pri..text = "Rs.",
          keyboardType: TextInputType.number,
          cursorWidth: 2.0,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.withOpacity(0.8),
            ),
            hintText: "Price of the Item",
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          )),
    );
  }

  Widget con() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: new TextFormField(
          onChanged: (value) {
            _contact = value;
          },
          cursorColor: Colors.red,
          controller: _con..text = '+977',
          keyboardType: TextInputType.number,
          cursorWidth: 2.0,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.withOpacity(0.8),
            ),
            hintText: "Contact number",
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          )),
    );
  }

  Widget des() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 40,
      width: 380,
      child: Row(
        children: <Widget>[
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19.0),
          ),
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.help_outline,
            color: Colors.grey.withOpacity(0.6),
          )
        ],
      ),
    );
  }

  Widget desBox() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: new TextFormField(
          onChanged: (value) {
            _desc = value;
          },
          cursorColor: Colors.red,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          cursorWidth: 2.0,
          controller: des1,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.withOpacity(0.8),
            ),
            hintText: "Add an optional description",
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          )),
    );
  }

  Widget type() {
    return Container(
      margin: EdgeInsets.only(right: 200),
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("userupload").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading.....");
            } else {
              List<DropdownMenuItem> currencyItems = [];
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                DocumentSnapshot snap = snapshot.data.documents[i];
                currencyItems.add(
                  DropdownMenuItem(
                    child: Text(
                      snap.documentID,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    value: "${snap.documentID}",
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.image, size: 25.0, color: Color(0xff11b719)),
                  SizedBox(width: 50.0),
                  DropdownButton(
                    items: currencyItems,
                    onChanged: (currencyValue) {
                      setState(() {
                        selectType = currencyValue;
                      });
                    },
                    value: selectType,
                    isExpanded: false,
                    hint: new Text(
                      "Item Type",
                      style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget itemtype() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 40,
      width: 380,
      child: Row(
        children: <Widget>[
          Text(
            "Select your item type",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19.0),
          ),
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.help_outline,
            color: Colors.grey.withOpacity(0.6),
          )
        ],
      ),
    );
  }

  Widget contactNo() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 40,
      width: 380,
      child: Row(
        children: <Widget>[
          Text(
            "Contact Number",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19.0),
          ),
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.help_outline,
            color: Colors.grey.withOpacity(0.6),
          )
        ],
      ),
    );
  }

  Widget upbtn(BuildContext context) {
    return Container(
      width: 350,
      height: 40,
      child: RaisedButton(
        color: Colors.deepOrange,
        onPressed: () {
          _saveCard(context);
          Future.delayed(Duration(seconds: 3), () {
            titl1.clear();
            des1.clear();
            _pri.clear();
            _con.clear();
          });
        },
        child: Text(
          "Publish",
          style: TextStyle(color: Colors.white),
        ),
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
}
