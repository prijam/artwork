import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'firebaseHandler/auth.dart';
import 'firebaseHandler/userModel.dart';

class Test extends StatefulWidget {
  final FirebaseUser firebaseUser;

  Test({this.firebaseUser});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  ScrollController _scrollController = ScrollController();
  var customPhoto = Image.asset("img/upload.gif");
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Future.delayed(
        Duration.zero,
            () => setState(() {
          _image = image;
        }));
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.setPixels(0.0) <=
          _scrollController.position.setPixels(0.1)) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        child: Container(
          height: 1000,
          child: Column(
            children: <Widget>[
              title(),
              header(),
              ImageBox(),
              btn(),
              des(),
              desBox(),
              Container(
                  margin: EdgeInsets.only(top: 10,
                  left:15,right: 15),
                  child: Divider(
                    thickness: 0.5,
                  )),
              pric(),
              pri(),

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
              cursorColor: Colors.red,
              cursorWidth: 2.0,
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
      margin: EdgeInsets.only(left:20, top: 5),
      child: StreamBuilder<User>(
        stream: Auth.getUser(widget.firebaseUser.uid),
        builder: (_, snapshot) {
          return snapshot.hasData ? Row(children: <Widget>[
            CircleAvatar(
              radius: 17.0,
              backgroundImage:
              NetworkImage(snapshot.data.profilePictureURL),
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0,left: 15),
              child: Text(snapshot.data.firstName,style: TextStyle(
                color: Colors.blueAccent[400],
                fontWeight: FontWeight.w600
              ),),
            )

          ],) : Center(child: Container());
        },
      ),
    );
  }
  Widget ImageBox(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: Colors.red,
      height: 200,
      width:380,
      child: _image != null
      ? Image.file(_image,fit: BoxFit.cover,)
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
  Widget btn(){
    return Container(
      margin: EdgeInsets.only(top:30),
      height:60,
      width: 380,
      child: RaisedButton(
        elevation: 2.0,
        color: Colors.white,
        onPressed: (){
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
        Icon(Icons.photo_library,color: Colors.grey.withOpacity(0.6),size:35.0,),
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
                child: Text("Image or GIF",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  fontFamily: 'font3',
                ),),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text("PNG, JPG, GIF",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  fontFamily: 'font3',
                  color: Colors.grey.withOpacity(0.78)
                ),),
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
  Widget pric(){
    return Container(
      margin: EdgeInsets.only(top:20),
      height: 40,
      width: 380,
      child: Row(
        children: <Widget>[
          Text("Price",style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 19.0
          ),),
          SizedBox(
            width: 6,
          ),
          Icon(Icons.monetization_on,color: Colors.grey.withOpacity(0.6),)
        ],
      ),
    );
  }
  Widget pri(){
    return Container(
      margin: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: new TextFormField(
          cursorColor: Colors.red,
          cursorWidth: 2.0,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize:15,
              color: Colors.grey.withOpacity(0.8),
            ),
            hintText: "Price of the Item",
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          )),
    );
  }
  Widget des(){
    return Container(
      margin: EdgeInsets.only(top:20),
      height: 40,
      width: 380,
      child: Row(
        children: <Widget>[
          Text("Description",style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 19.0
          ),),
          SizedBox(
            width: 6,
          ),
          Icon(Icons.help_outline,color: Colors.grey.withOpacity(0.6),)
        ],
      ),
    );
  }
  Widget desBox(){
    return Container(
      margin: EdgeInsets.only(left: 15),
      color: Colors.white,
      child: new TextFormField(
          cursorColor: Colors.red,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          cursorWidth: 2.0,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize:15,
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
}
