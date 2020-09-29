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
  ScrollController _scrollController;
  bool seemore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  StreamBuilder(
                    stream: Firestore.instance
                        .collection("users")
                        .document(widget.firebaseUser.uid)
                        .snapshots(),
                    builder: (_, snapshot) {
                      return snapshot.hasData
                          ? CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                  snapshot.data["profilePictureURL"]),
                              backgroundColor: Colors.transparent,
                            )
                          : Container();
                    },
                  ),
                  Positioned(
                    right: 0,
                    top: 2,
                    left: 26,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      width: 20,
                      height: 10,
                    ),
                  ),
                ],
              )),
          actions: <Widget>[
            Image.asset(
              "img/fea.jpg",
            ),
            Container(
              width: 5.0,
            ),
          ],
        ),
        body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      backgroundColor: Colors.white,
                      leading: Container(),
                      expandedHeight: 120.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: Image.asset(
                            "img/in.png",
                            height: 65,
                          )),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Inbox",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
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
                                    ? Text(snapshot.data.documents.length.toString())
                                    : Text("");
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Center(
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
                          ? ListView.separated(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (_, index) {
                                var uploadTime = DateTime.parse(snapshot
                                    .data.documents[index]["sendDate&Time"]
                                    .toDate()
                                    .toString());
                                final hours =
                                    today.difference(uploadTime).inHours;
                                final day = today.difference(uploadTime).inDays;
                                final daysString = day;
                                final hourString = hours;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          height: 40,
                                          width: 254,
                                          child: StreamBuilder<User>(
                                            stream: Auth.getUser(snapshot.data
                                                .documents[index]["senderID"]),
                                            builder: (_, snapshot) {
                                              return snapshot.hasData
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 20.0,
                                                          backgroundImage:
                                                              NetworkImage(snapshot
                                                                  .data
                                                                  .profilePictureURL),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              snapshot.data
                                                                  .firstName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  : Container();
                                            },
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 60.0),
                                      child: Text(
                                        snapshot.data.documents[index]
                                            ["message"],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => Column(
                                    children: <Widget>[
                                      Container(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        child: Divider(
                                          color: Colors.black.withOpacity(0.8),
                                          thickness: 0.2,
                                        ),
                                      ),
                                    ],
                                  ))
                          : Container();
                    }))));
  }

//  Widget firstTab() {
//    return Container(
//      margin: EdgeInsets.only(right: 5, top: 15),
//      decoration: new BoxDecoration(
//        border: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.0),
//        borderRadius: new BorderRadius.all(Radius.circular(15.0)),
//      ),
//      width: 380,
//      height: 50,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Padding(
//              padding: EdgeInsets.only(left: 20),
//              child: Text(
//                "All messages",
//                style: TextStyle(fontFamily: "font1", fontSize: 18.0),
//              )),
//          Padding(
//            padding: EdgeInsets.only(right: 10),
//            child: Icon(
//              Icons.keyboard_arrow_down,
//              color: Colors.grey,
//              size: 30,
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  Widget body() {
//    return Container(
//      height: 698,
//      width: 350,
//      child: StreamBuilder(
//        stream: Firestore.instance
//            .collection("users")
//            .document(widget.firebaseUser.uid)
//            .collection("User_Data")
//            .document("Messages")
//            .collection("Inbox")
//            .snapshots(),
//        builder: (_, snapshot) {
//          return snapshot.hasData
//              ? ListView.builder(
//              itemCount: snapshot.data.documents.length,
//              itemBuilder: (_, index) {
//                var uploadTime = DateTime.parse(snapshot
//                    .data.documents[index]["sendDate&Time"]
//                    .toDate()
//                    .toString());
//                final hours = today.difference(uploadTime).inHours;
//                final day = today.difference(uploadTime).inDays;
//                final daysString = day;
//                final hourString = hours;
//
//                return Padding(
//                  padding: const EdgeInsets.only(top: 10),
//                  child: InkWell(
//                    onTap: () {},
//                    child: Card(
//                      elevation: 5.0,
//                      shape: RoundedRectangleBorder(
//                        side: BorderSide(color: Colors.white70, width: 1),
//                        borderRadius: BorderRadius.circular(10),
//                      ),
//                      child: Container(
//                        margin: EdgeInsets.only(top: 10),
//                        decoration: BoxDecoration(
//                          borderRadius:
//                          BorderRadius.all(Radius.circular(10.0)),
//                        ),
//                        height: 230,
//                        width: 250,
//                        child: Stack(
//                          children: <Widget>[
//                            Positioned(
//                                top: 40,
//                                left: 20,
//                                child: Container(
//                                  child: ClipRRect(
//                                    borderRadius: BorderRadius.all(
//                                        Radius.circular(10.0)),
//                                    child: Image.network(
//                                      snapshot.data.documents[index]
//                                      ["itemImage"],
//                                      height: 100,
//                                      width: 290,
//                                      fit: BoxFit.cover,
//                                      filterQuality: FilterQuality.high,
//                                    ),
//                                  ),
//                                )),
//                            Positioned(
//                              left: 22,
//                              child: Container(
//                                  height: 40,
//                                  width: 254,
//                                  child: StreamBuilder<User>(
//                                    stream: Auth.getUser(snapshot
//                                        .data.documents[index]["senderID"]),
//                                    builder: (_, snapshot) {
//                                      return snapshot.hasData
//                                          ? Row(
//                                        children: <Widget>[
//                                          CircleAvatar(
//                                            radius: 17.0,
//                                            backgroundImage:
//                                            NetworkImage(snapshot
//                                                .data
//                                                .profilePictureURL),
//                                            backgroundColor:
//                                            Colors.transparent,
//                                          ),
//                                          Padding(
//                                            padding:
//                                            const EdgeInsets.only(
//                                                top: 2.0,
//                                                left: 10),
//                                            child: Text(
//                                              snapshot.data.firstName,
//                                              style: TextStyle(
//                                                  color: Colors
//                                                      .blueAccent[
//                                                  400],
//                                                  fontSize: 16.0,
//                                                  fontWeight:
//                                                  FontWeight
//                                                      .w600),
//                                            ),
//                                          )
//                                        ],
//                                      )
//                                          : Container();
//                                    },
//                                  )),
//                            ),
//                            Positioned(
//                              top: 146,
//                              right: -3,
//                              child: Container(
//                                height: 20,
//                                width: 80,
//                                child: Text(
//                                  daysString == 0 ? "$hourString hrs ago" : "$daysString days ago",
//                                  style: TextStyle(
//                                      fontFamily: "font2",
//                                      color: Colors.grey),
//                                ),
//                              ),
//                            ),
//                            Positioned(
//                              bottom: 5,
//                              right: -3,
//                              child: Container(
//                                height: 20,
//                                width: 80,
//                                child: Text(
//                                  snapshot.data.documents[index]
//                                  ["buyerPrice"],
//                                  style: TextStyle(
//                                      fontFamily: "font2",
//                                      color: Colors.red),
//                                ),
//                              ),
//                            ),
//                            Positioned(
//                              bottom: 20,
//                              right: 13,
//                              child: Container(
//                                height: 20,
//                                width: 60,
//                                child: Text(
//                                  "Offered",
//                                  style: TextStyle(
//                                      fontFamily: "font2",
//                                      fontSize: 13.0,
//                                      color: Colors.grey),
//                                ),
//                              ),
//                            ),
//                            Positioned(
//                              bottom: 43,
//                              left: 20,
//                              child: Container(
//                                height: 45,
//                                width: 210,
//                                child: Text(
//                                  snapshot.data.documents[index]["title"],
//                                  style: TextStyle(
//                                      fontFamily: "font2",
//                                      color: Colors.grey),
//                                ),
//                              ),
//                            ),
//                            Positioned(
//                              bottom: 1,
//                              left: 20,
//                              child: Container(
//                                height: 65,
//                                width: 228,
//                                child: Text(
//                                  snapshot.data.documents[index]["message"],
//                                  style: TextStyle(
//                                      fontFamily: "font2",
//                                      color: Colors.black.withOpacity(0.9)),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
////                      child: Card(
////                        elevation: 1.0,
////                        child: Container(
////                            height: 130,
////                            width: 250,
////                            child: Stack(
////                              children: <Widget>[
//////                                Positioned(
//////                                  top:30,
//////                                  child: StreamBuilder<User>(
//////                                    stream: Auth.getUser(
//////                                        snapshot.data.documents[index]["senderID"]),
//////                                    builder: (_, snapshot) {
//////                                      return snapshot.hasData
//////                                          ? Row(
//////                                              children: <Widget>[
//////                                                Container(
//////                                                  margin: EdgeInsets.only(
//////                                                      left: 20, bottom:30),
//////                                                  child: CircleAvatar(
//////                                                    radius: 22.0,
//////                                                    backgroundImage: NetworkImage(
//////                                                        snapshot.data
//////                                                            .profilePictureURL),
//////                                                    backgroundColor:
//////                                                        Colors.transparent,
//////                                                  ),
//////                                                ),
//////                                                Container(
//////                                                    margin: EdgeInsets.only(
//////                                                        bottom: 30, left: 14),
//////                                                    child: Text(
//////                                                      snapshot.data.firstName,
//////                                                      style: TextStyle(
//////                                                          color: Colors.blueGrey,
//////                                                          fontFamily: 'font2'),
//////                                                    ))
//////                                              ],
//////                                            )
//////                                          : Container();
//////                                    },
//////                                  ),
//////                                ),
//////                                Positioned(
//////                                    top: 1,
//////                                    left: 200,
//////                                    child: Container(
//////                                        height: 40,
//////                                        width: 250,
//////                                        child: Text(
//////                                          snapshot.data.documents[index]
//////                                              ["buyerPrice"],
//////                                          style: TextStyle(
//////                                              color: Colors.grey,
//////                                              fontWeight: FontWeight.w800),
//////                                        ))),
//////                                Positioned(
//////                                    top: 22,
//////                                    left: 78,
//////                                    child: Container(
//////                                        height: 40,
//////                                        width: 250,
//////                                        child: Text(
//////                                          snapshot.data.documents[index]
//////                                              ["message"],
//////                                          style: TextStyle(
//////                                              color: Colors.grey,
//////                                              fontWeight: FontWeight.w800),
//////                                        ))),
////                              ],
////                            )),
////                      ),
//                );
//              })
//              : Container();
//        },
//      ),
//    );
//  }
}
