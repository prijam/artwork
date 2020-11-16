import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/firebbstore.dart';
import 'package:artstore/firebaseHandler/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:url_launcher/url_launcher.dart';

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

  bool showloading = false;

  Future _sendMsg(
      BuildContext context, AsyncSnapshot snapshot, int index) async {
    DateTime now = DateTime.now();
    setState(() {
      showloading = true;
    });
    Firestore.instance
        .collection("users")
        .document(snapshot.data.documents[index]["uID"])
        .collection("User_Data")
        .document("Messages")
        .collection("Inbox")
        .document()
        .setData({
      "message": message,
      "senderID": widget.firebaseUser.uid,
      "sendDate&Time": now,
      "buyerPrice": _price,
      "itemImage": snapshot.data.documents[index]["itemImage"],
      "title": snapshot.data.documents[index]["title"],
    }).whenComplete(() {
      msgcon.clear();
      Navigator.of(context).pop();
    });
  }

  _onTapImage(BuildContext context, AsyncSnapshot snapshot) {
    return PageView.builder(
        controller: PageController(viewportFraction: 1),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (_, index) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 18.0),
              child: SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    margin: EdgeInsets.only(top: 100),
                    height: 700,
                    width: 450,
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0, top: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: new Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 35.0,
                                ),
                                onPressed: () {
                                  msgcon.clear();
                                  _pri.clear();
                                  Navigator.of(context).pop(null);
                                }),
                          ),
                        ),
                        StreamBuilder<User>(
                          stream: Auth.getUser(
                              snapshot.data.documents[index]["uID"]),
                          builder: (_, snapshot) {
                            return snapshot.hasData
                                ? Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 20.0,
                                              backgroundImage: NetworkImage(
                                                  snapshot
                                                      .data.profilePictureURL),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3.0, left: 18),
                                          child: Text(
                                            snapshot.data.firstName,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 80.0),
                                          child: FlatButton(
                                            child: Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                            color: Colors.green,
                                            onPressed: () => launch(
                                                "tel://${snapshot.data.number}"),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data.documents[index]["itemImage"],
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              height: 300,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.documents[index]["title"],
                                  style: TextStyle(
                                      fontFamily: "font2", fontSize: 18),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    snapshot.data.documents[index]["price"]
                                        .replaceAllMapped(reg, mathFunc),
                                    style: TextStyle(
                                        fontFamily: "font2", color: Colors.red),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10),
                          child: Text(
                            snapshot.data.documents[index]["description"],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 10),
                          child: Row(
                            children: [
                              Text("Your Bidding Price :"),
                              pri(),
                            ],
                          ),
                        ),
                        messageBox(),
                      Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50, top: 8),
                                child: RaisedButton(
                                  color: Colors.deepOrange,
                                  onPressed: () {
                                    _sendMsg(context, snapshot, index);
                                  },
                                  child: Text(
                                    "Send Message",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    )),
              ),
            ),
          );
        });
  }

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
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
              ),
              tabbar(),
              Positioned(top: 40, child: tabview()),
              // Positioned(
              //   bottom: 85.0,
              //   child: Container(
              //     height: 100,
              //     width: 500,
              //     decoration: BoxDecoration(color: Colors.black),
              //   ),
              // )
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
      height: 765.0,
      width: 412,
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
                        mainAxisSpacing: 13,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (
                                    context,
                                  ) =>
                                      _onTapImage(context, snapshot));
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
                        mainAxisSpacing: 13,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (
                                    context,
                                  ) =>
                                      _onTapImage(context, snapshot));
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
                        mainAxisSpacing: 13,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (
                                    context,
                                  ) =>
                                      _onTapImage(context, snapshot));
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
                        mainAxisSpacing: 13,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (
                                    context,
                                  ) =>
                                      _onTapImage(context, snapshot));
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
                        mainAxisSpacing: 13,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (
                                    context,
                                  ) =>
                                      _onTapImage(context, snapshot));
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

  Widget messageBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10),
      child: Container(
        height: 80,
        width: 300,
        child: new TextFormField(
            onChanged: (value) {
              message = value;
            },
            cursorColor: Colors.grey,
            textInputAction: TextInputAction.done,
            maxLines: 15,
            controller: msgcon,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFDBEDFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey.withOpacity(0.8),
              ),
              hintText: "Write your message here..",
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            )),
      ),
    );
  }

  Widget pri() {
    return Container(
      height: 20,
      width: 200,
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
              color: Colors.red.withOpacity(0.8),
            ),
            hintText: "Price goes here",
          ),
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}
