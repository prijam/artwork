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
            Container(
              width: 5.0,
            ),
            IconButton(
              icon: new Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(null),
            )
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
                      expandedHeight: 100.0,
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
                            "Messages",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
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
                        .orderBy("sendDate&Time", descending: true)
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
                                final min =
                                    today.difference(uploadTime).inMinutes;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          height: 80,
                                          child: StreamBuilder<User>(
                                            stream: Auth.getUser(snapshot.data
                                                .documents[index]["senderID"]),
                                            builder: (_, snapshot) {
                                              return snapshot.hasData
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
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
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          270.0),
                                                              child: Text(
                                                                hourString == 0
                                                                    ? min.toString() +
                                                                        " min ago"
                                                                    : daysString ==
                                                                            0
                                                                        ? hourString.toString() +
                                                                            " hours ago"
                                                                        : day.toString() +
                                                                            " days ago",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .brown,
                                                                    fontSize:
                                                                        13.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                          ],
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
                                                                      .blueGrey,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        snapshot.data.documents[index]
                                            ["message"],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Offered Price : " +
                                                snapshot.data.documents[index]
                                                    ["buyerPrice"],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.green
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 195.0),
                                          child: IconButton(
                                            onPressed: () async {
                                              delete(index);
                                            },
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
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
                          : CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            );
                    }))));
  }

  void delete(int index) async {
    CollectionReference col = Firestore.instance
        .collection("users")
        .document(widget.firebaseUser.uid)
        .collection("User_Data")
        .document("Messages")
        .collection("Inbox");
    QuerySnapshot q = await col.getDocuments();
    q.documents[index].reference.delete();
  }
}
