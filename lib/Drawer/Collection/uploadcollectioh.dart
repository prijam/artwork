import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/firebbstore.dart';
import 'package:artstore/firebaseHandler/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Collection extends StatefulWidget {
  final FirebaseUser firebaseUser;

  Collection({this.firebaseUser});

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> with TickerProviderStateMixin {
  TabController _tabController;
  firestore fire = firestore();
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  String message = "";
  TextEditingController msgcon = TextEditingController();
  String _price = "";
  TextEditingController _pri = TextEditingController();
  DateTime now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(now);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: new Icon(
              Icons.close,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.black,
          height: 950,
          width: 450,
          child: Column(
            children: <Widget>[
              Container(
                height: 720,
                width: 450,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0))),
                child: Column(
                  children: <Widget>[
                    tabbar(),
                    tabview(),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(right: 60),
                  height: 84,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        height: 50,
                        width: 70,
                        child: Text(
                          "Top sellers",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontSize: 18.0,
                              fontFamily: 'font2'),
                        ),
                      ),
                      Image.asset(
                        "img/av1.png",
                        height: 50,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        "img/av4.png",
                        height: 50,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        "img/av5.png",
                        height: 50,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        "img/4.png",
                        height: 50,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tabbar() {
    return DefaultTabController(
      length: 5,
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.black,
        indicatorColor: Colors.white,
        controller: _tabController,
        unselectedLabelColor: Colors.grey.withOpacity(0.4),
        tabs: <Widget>[
          Tab(
            child: Text('Explore',
                style: TextStyle(
                  fontSize: 35.0,
                )),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Art',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Paint',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Craft',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Illustration',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabview() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0))),
      height: 610.0,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[explore(), art(), paint(), craft(), illu()],
      ),
    );
  }

  Widget explore() {
    var path = Firestore.instance.collection("explore").snapshots();
    return StreamBuilder(
      stream: path,
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: snapshot.data.documents.length != 0
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          String price =
                              snapshot.data.documents[index]["price"];
                          _onTapImage(BuildContext context) {
                            DocumentReference documentReference = Firestore
                                .instance
                                .collection('explore')
                                .document();
                            Future _sendMsg(BuildContext context) async {
                              print("Entering firebase");
                              Firestore.instance
                                  .collection("users")
                                  .document(
                                      snapshot.data.documents[index]["uID"])
                                  .collection("User_Data")
                                  .document("Messages")
                                  .collection("Inbox")
                                  .document()
                                  .setData({
                                "message": message,
                                "senderID": widget.firebaseUser.uid,
                                "sendDate&Time": now,
                                "buyerPrice": _price,
                                "docID": documentReference.documentID,
                              }).whenComplete(() {
                                msgcon.clear();
                                Navigator.of(context).pop();
                              });
                            }

                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Padding(
                                padding: const EdgeInsets.only(
                                    right: 18.0, left: 18.0),
                                child: SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    margin: EdgeInsets.only(top: 100),
                                    height: 500,
                                    width: 400,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 300.0),
                                          child: IconButton(
                                              icon: new Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 35.0,
                                              ),
                                              onPressed: () {
                                                msgcon.clear();
                                                _pri.clear();
                                                Navigator.of(context).pop(null);
                                              }),
                                        ),
                                        Positioned(
                                          top: 50,
                                          left: 42,
                                          child: Container(
                                              height: 50,
                                              width: 250,
                                              child: StreamBuilder<User>(
                                                stream: Auth.getUser(snapshot
                                                    .data
                                                    .documents[index]["uID"]),
                                                builder: (_, snapshot) {
                                                  return snapshot.hasData
                                                      ? Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                              radius: 17.0,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      snapshot
                                                                          .data
                                                                          .profilePictureURL),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 6.0,
                                                                      left: 15),
                                                              child: Text(
                                                                snapshot.data
                                                                    .firstName,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .blueAccent[
                                                                        400],
                                                                    fontSize:
                                                                        16.0,
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
                                          top: 100,
                                          left: 40,
                                          child: Container(
                                            height: 200,
                                            width: 300,
                                            child: Image.network(
                                              snapshot.data.documents[index]
                                                  ["itemImage"],
                                              fit: BoxFit.cover,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 295,
                                          left: 40,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 40, top: 15),
                                            height: 20,
                                            width: 254,
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  ["title"],
                                              style: TextStyle(
                                                  fontFamily: "font2"),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 328,
                                          left: 40,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 95),
                                            height: 60,
                                            width: 200,
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  ["description"],
                                              style: TextStyle(
                                                  fontFamily: "font1",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 160,
                                          right: 1,
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            child: Text(
                                              price.replaceAllMapped(
                                                  reg, mathFunc),
                                              style: TextStyle(
                                                  fontFamily: "font2",
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 140,
                                          right: 2,
                                          child: Container(
                                            height: 18,
                                            width: 80,
                                            child: Text("Your price"),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 132,
                                            right: -19,
                                            child: pri()),
                                        Positioned(
                                            bottom: 50,
                                            left: 40,
                                            child: messageBox()),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Container(
                                            width: 350,
                                            height: 40,
                                            child: RaisedButton(
                                              color: Colors.deepOrange,
                                              onPressed: () {
                                                _sendMsg(context);
                                              },
                                              child: Text(
                                                "Send Message",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => _onTapImage(context));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "img/img.gif",
                                  image: snapshot.data.documents[index]
                                      ["itemImage"],
                                  fit: BoxFit.cover,
                                  fadeInCurve: Curves.easeIn,
                                ),
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.0 : 1.60);
                        },
                      )
                    : Container(
                        child: Container(
                            margin: EdgeInsets.only(top: 80, left: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 70),
                                  height: 150,
                                  child: Image.asset(
                                    "img/as.png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "Nothing to see here",
                                      style: TextStyle(
                                          fontFamily: "font2", fontSize: 18.0),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(right: 30, top: 10),
                                    child: Text(
                                      "Swipe left or right to see more products",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.withOpacity(0.8)),
                                    )),
                              ],
                            )),
                      ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget art() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Art")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: snapshot.data.documents.length != 0
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          String price =
                              snapshot.data.documents[index]["price"];
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder: "img/img.gif",
                                image: snapshot.data.documents[index]
                                    ["itemImage"],
                                fit: BoxFit.cover,
                                fadeInCurve: Curves.easeIn,
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.0 : 1.60);
                        },
                      )
                    : Container(
                        child: Container(
                            margin: EdgeInsets.only(top: 130, left: 40),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 70),
                                  height: 150,
                                  child: Image.asset(
                                    "img/as.png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "Nothing to see here",
                                      style: TextStyle(
                                          fontFamily: "font2", fontSize: 18.0),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(right: 30, top: 10),
                                    child: Text(
                                      "Swipe left or right to see more products",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.withOpacity(0.8)),
                                    )),
                              ],
                            )),
                      ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget paint() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Paint")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: snapshot.data.documents.length != 0
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder: "img/img.gif",
                                image: snapshot.data.documents[index]
                                    ["itemImage"],
                                fit: BoxFit.cover,
                                fadeInCurve: Curves.easeIn,
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.0 : 1.60);
                        },
                      )
                    : Container(
                        child: Container(
                            margin: EdgeInsets.only(top: 130, left: 40),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 70),
                                  height: 150,
                                  child: Image.asset(
                                    "img/as.png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "Nothing to see here",
                                      style: TextStyle(
                                          fontFamily: "font2", fontSize: 18.0),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(right: 30, top: 10),
                                    child: Text(
                                      "Swipe left or right to see more products",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.withOpacity(0.8)),
                                    )),
                              ],
                            )),
                      ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget craft() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Craft")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: snapshot.data.documents.length != 0
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          String price =
                              snapshot.data.documents[index]["price"];
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder: "img/img.gif",
                                image: snapshot.data.documents[index]
                                    ["itemImage"],
                                fit: BoxFit.cover,
                                fadeInCurve: Curves.easeIn,
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.0 : 1.60);
                        },
                      )
                    : Container(
                        child: Container(
                            margin: EdgeInsets.only(top: 130, left: 40),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 70),
                                  height: 150,
                                  child: Image.asset(
                                    "img/as.png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "Nothing to see here",
                                      style: TextStyle(
                                          fontFamily: "font2", fontSize: 18.0),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(right: 30, top: 10),
                                    child: Text(
                                      "Swipe left or right to see more products",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.withOpacity(0.8)),
                                    )),
                              ],
                            )),
                      ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget illu() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Illustration")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: snapshot.data.documents.length != 0
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          String price =
                              snapshot.data.documents[index]["price"];
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              child: FadeInImage.assetNetwork(
                                placeholder: "img/img.gif",
                                image: snapshot.data.documents[index]
                                    ["itemImage"],
                                fit: BoxFit.cover,
                                fadeInCurve: Curves.easeIn,
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.0 : 1.60);
                        },
                      )
                    : Container(
                        child: Container(
                            margin: EdgeInsets.only(top: 130, left: 40),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 70),
                                  height: 150,
                                  child: Image.asset(
                                    "img/as.png",
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "Nothing to see here",
                                      style: TextStyle(
                                          fontFamily: "font2", fontSize: 18.0),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(right: 30, top: 10),
                                    child: Text(
                                      "Swipe left or right to see more products",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.withOpacity(0.8)),
                                    )),
                              ],
                            )),
                      ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget messageBox() {
    return Container(
      height: 70,
      width: 300,
      color: Colors.transparent,
      child: new TextFormField(
          onChanged: (value) {
            message = value;
          },
          cursorColor: Colors.red,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          controller: msgcon,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey.withOpacity(0.8),
            ),
            hintText: "Your message here",
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          )),
    );
  }

  Widget pri() {
    return Container(
      height: 20,
      width: 100,
      margin: EdgeInsets.only(left: 15),
      color: Colors.transparent,
      child: new TextFormField(
          onChanged: (value) {
            _price = value;
          },
          cursorColor: Colors.red,
          controller: _pri..text = "Rs.".replaceAllMapped(reg, mathFunc),
          keyboardType: TextInputType.number,
          cursorWidth: 2.0,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.withOpacity(0.8),
            ),
            hintText: "Your Price",
          ),
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
