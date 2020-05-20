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
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  DateTime today = new DateTime.now();

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
                      margin: EdgeInsets.only(right: 210, top: 7),
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
                      margin: EdgeInsets.only(right: 210, top: 20),
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
          body()
        ],
      ),
    );
  }

  Widget firstTab() {
    return Container(
      margin: EdgeInsets.only(right: 5, top: 15),
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.0),
        borderRadius: new BorderRadius.all(Radius.circular(15.0)),
      ),
      width: 380,
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
      height: 698,
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
                    var uploadTime = DateTime.parse(snapshot
                        .data.documents[index]["sendDate&Time"]
                        .toDate()
                        .toString());
                    final hours = today.difference(uploadTime).inHours;
                    final day = today.difference(uploadTime).inDays;
                    final daysString = day;
                    final hourString = hours;

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            height: 230,
                            width: 250,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                    top: 40,
                                    left: 20,
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Image.network(
                                          snapshot.data.documents[index]
                                              ["itemImage"],
                                          height: 100,
                                          width: 290,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  left: 22,
                                  child: Container(
                                      height: 40,
                                      width: 254,
                                      child: StreamBuilder<User>(
                                        stream: Auth.getUser(snapshot
                                            .data.documents[index]["senderID"]),
                                        builder: (_, snapshot) {
                                          return snapshot.hasData
                                              ? Row(
                                                  children: <Widget>[
                                                    CircleAvatar(
                                                      radius: 17.0,
                                                      backgroundImage:
                                                          NetworkImage(snapshot
                                                              .data
                                                              .profilePictureURL),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              left: 10),
                                                      child: Text(
                                                        snapshot.data.firstName,
                                                        style: TextStyle(
                                                            color: Colors
                                                                    .blueAccent[
                                                                400],
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Container();
                                        },
                                      )),
                                ),
                                Positioned(
                                  top: 146,
                                  right: -3,
                                  child: Container(
                                    height: 20,
                                    width: 80,
                                    child: Text(
                                      daysString == 0 ? "$hourString hrs ago" : "$daysString days ago",
                                      style: TextStyle(
                                          fontFamily: "font2",
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: -3,
                                  child: Container(
                                    height: 20,
                                    width: 80,
                                    child: Text(
                                      snapshot.data.documents[index]
                                          ["buyerPrice"],
                                      style: TextStyle(
                                          fontFamily: "font2",
                                          color: Colors.red),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  right: 13,
                                  child: Container(
                                    height: 20,
                                    width: 60,
                                    child: Text(
                                      "Offered",
                                      style: TextStyle(
                                          fontFamily: "font2",
                                          fontSize: 13.0,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 43,
                                  left: 20,
                                  child: Container(
                                    height: 45,
                                    width: 210,
                                    child: Text(
                                      snapshot.data.documents[index]["title"],
                                      style: TextStyle(
                                          fontFamily: "font2",
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  left: 20,
                                  child: Container(
                                    height: 65,
                                    width: 228,
                                    child: Text(
                                      snapshot.data.documents[index]["message"],
                                      style: TextStyle(
                                          fontFamily: "font2",
                                          color: Colors.black.withOpacity(0.9)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
//                      child: Card(
//                        elevation: 1.0,
//                        child: Container(
//                            height: 130,
//                            width: 250,
//                            child: Stack(
//                              children: <Widget>[
////                                Positioned(
////                                  top:30,
////                                  child: StreamBuilder<User>(
////                                    stream: Auth.getUser(
////                                        snapshot.data.documents[index]["senderID"]),
////                                    builder: (_, snapshot) {
////                                      return snapshot.hasData
////                                          ? Row(
////                                              children: <Widget>[
////                                                Container(
////                                                  margin: EdgeInsets.only(
////                                                      left: 20, bottom:30),
////                                                  child: CircleAvatar(
////                                                    radius: 22.0,
////                                                    backgroundImage: NetworkImage(
////                                                        snapshot.data
////                                                            .profilePictureURL),
////                                                    backgroundColor:
////                                                        Colors.transparent,
////                                                  ),
////                                                ),
////                                                Container(
////                                                    margin: EdgeInsets.only(
////                                                        bottom: 30, left: 14),
////                                                    child: Text(
////                                                      snapshot.data.firstName,
////                                                      style: TextStyle(
////                                                          color: Colors.blueGrey,
////                                                          fontFamily: 'font2'),
////                                                    ))
////                                              ],
////                                            )
////                                          : Container();
////                                    },
////                                  ),
////                                ),
////                                Positioned(
////                                    top: 1,
////                                    left: 200,
////                                    child: Container(
////                                        height: 40,
////                                        width: 250,
////                                        child: Text(
////                                          snapshot.data.documents[index]
////                                              ["buyerPrice"],
////                                          style: TextStyle(
////                                              color: Colors.grey,
////                                              fontWeight: FontWeight.w800),
////                                        ))),
////                                Positioned(
////                                    top: 22,
////                                    left: 78,
////                                    child: Container(
////                                        height: 40,
////                                        width: 250,
////                                        child: Text(
////                                          snapshot.data.documents[index]
////                                              ["message"],
////                                          style: TextStyle(
////                                              color: Colors.grey,
////                                              fontWeight: FontWeight.w800),
////                                        ))),
//                              ],
//                            )),
//                      ),
                    );
                  })
              : Container();
        },
      ),
    );
  }
}
