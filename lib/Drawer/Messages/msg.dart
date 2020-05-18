import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final FirebaseUser firebaseUser;

  MessageList({this.firebaseUser});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: new Container(),
        actions: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection("users")
                .document(widget.firebaseUser.uid)
                .collection("User_Data")
                .document("Messages")
                .collection("Inbox")
                .snapshots(),
            builder: (_, snapshot) {
              return snapshot.hasData
                  ? Container(
                      margin: EdgeInsets.only(right: 180, top: 7),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Messages",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            height: 20,
                            width: 30,
                            child: Text(
                              snapshot.data.documents.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ))
                  : Container(
                      margin: EdgeInsets.only(right: 230, top: 20),
                      child: Text(
                        "Messages",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0),
                      ),
                    );
            },
          ),
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: new Icon(
              Icons.close,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop(null),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          firstTab(),
        ],
      ),
    );
  }
  Widget firstTab(){
    return  Container(
      margin: EdgeInsets.only(left:30,top:25),
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.0),
        borderRadius:
        new BorderRadius.all(Radius.circular(15.0)),
      ),
      width: 350,
      height:50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("All messages",style: TextStyle(
                fontFamily: "font1",
                fontSize: 18.0
              ),)),
          Padding(
            padding: EdgeInsets.only(right:10),
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
