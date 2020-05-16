import 'package:artstore/Drawer/Collection/myuploads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstView extends StatefulWidget {
  final FirebaseUser firebaseUser;

  FirstView({this.firebaseUser});

  @override
  _FirstViewState createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Collection",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: 1010,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyUpload(
                  firebaseUser: widget.firebaseUser,
                )));
              },
              child: Container(
                height: 350,
                width: 400,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Text("My uploads",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      fontFamily: 'font2'),),
                    ),
                    Image.asset("img/upl.png",filterQuality: FilterQuality.high,fit: BoxFit.fill,),
                  ],
                )
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                height: 350,
                width: 400,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:30.0),
                      child: Text("Other uploads",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'font2')),
                    ),
                    Image.asset("img/coll.png",filterQuality: FilterQuality.high,fit: BoxFit.fill,),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
