import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors.white,
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
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          body()
        ],
      ),
    );
  }

  Widget firstTab() {
    return Container(
      margin: EdgeInsets.only(left: 35, top: 25),
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.0),
        borderRadius: new BorderRadius.all(Radius.circular(15.0)),
      ),
      width: 350,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "All messages",
                style: TextStyle(fontFamily: "font1", fontSize: 18.0),
              )),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget body() {
    return Container(
      height: 673,
      width: 350,
      child: StreamBuilder(
        stream: Firestore.instance
            .collection("users")
            .document(widget.firebaseUser.uid)
            .collection("User_Data")
            .document("Messages")
            .collection("Inbox")
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    return Container(
                      height:100,
                      width: 250,
                      child: Stack(
                        children: <Widget>[
                          StreamBuilder<User>(
                            stream:
                            Auth.getUser(snapshot.data.documents[index]["senderID"]),
                            builder: (_, snapshot) {
                              return snapshot.hasData
                                  ? Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20,bottom: 10),
                                    child: CircleAvatar(
                                      radius:22.0,
                                      backgroundImage: NetworkImage(
                                          snapshot.data.profilePictureURL),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Container(
                                      margin:EdgeInsets.only(bottom:30,left:14),
                                      child: Text(snapshot.data.firstName,style: TextStyle(
                                        color: Colors.blueGrey,fontFamily: 'font2'
                                      ),))
                                ],
                              )
                                  : Container();
                            },
                          ),
                          Positioned(
                              top:22,
                              left:78,
                              child: Container(
                                  height: 40,
                                  width: 250,
                                  child: Text(snapshot.data.documents[index]["message"],style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800
                                  ),))),
                        ],
                      )
                    );
                  })
              : Container();
        },
      ),
    );
  }
}
