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

  Future _sendMsg(
      BuildContext context, AsyncSnapshot snapshot, int index) async {
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
                              stream: Auth.getUser(
                                  snapshot.data.documents[index]["uID"]),
                              builder: (_, snapshot) {
                                return snapshot.hasData
                                    ? Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 17.0,
                                            backgroundImage: NetworkImage(
                                                snapshot
                                                    .data.profilePictureURL),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, left: 15),
                                            child: Text(
                                              snapshot.data.firstName,
                                              style: TextStyle(
                                                  color: Colors.blueAccent[400],
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600),
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
                            snapshot.data.documents[index]["itemImage"],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 295,
                        left: 40,
                        child: Container(
                          margin: EdgeInsets.only(right: 40, top: 15),
                          height: 20,
                          width: 254,
                          child: Text(
                            snapshot.data.documents[index]["title"],
                            style: TextStyle(fontFamily: "font2"),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 328,
                        left: 40,
                        child: Container(
                          margin: EdgeInsets.only(right: 95),
                          height: 70,
                          width: 250,
                          child: Text(
                            snapshot.data.documents[index]["description"],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 173,
                        right: 1,
                        child: Container(
                          height: 20,
                          width: 80,
                          child: Text(
                            snapshot.data.documents[index]["price"]
                                .replaceAllMapped(reg, mathFunc),
                            style: TextStyle(
                                fontFamily: "font2", color: Colors.red),
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
                      Positioned(bottom: 132, right: -19, child: pri()),
                      Positioned(bottom: 30, left: 40, child: messageBox()),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          width: 350,
                          height: 40,
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
                      ),
                    ],
                  ),
                ),
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
        child:Container(
          color: Colors.red,
          height: 1000,
          child: Stack(
            children: <Widget>[
              tabbar(),
              Positioned(
                  top:40,
                  child: tabview()),
              Positioned(
                top:650,
                child: ClipPath(
                  clipper: SideCutClipper(),
                  child: Container(
                    height: 155,
                    width:412,
                    color: Colors.black,
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
      height:760.0,
      width:400,
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
    return Container(
      height: 70,
      width: 300,
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
class SideCutClipper extends CustomClipper<Path> {
  // Play with scals to get more clear versions
  @override
  Path getClip(Size size) {
    double xFactor = 18, yFactor = 15;
    double height = size.height;
    double startY = (height - height / 3) - yFactor;
    double xVal = size.width;
    double yVal = 0;
    final path = Path();

    path.lineTo(xVal, yVal);

    yVal = startY;
    path.lineTo(xVal, yVal);

    double scale = 1.4;
    path.cubicTo(xVal, yVal, xVal, yVal + yFactor * scale,
        xVal - xFactor * scale, yVal + yFactor * scale);
    xVal = xVal - xFactor * scale;
    yVal = yVal + yFactor * scale;

    double scale1 = 1;
    path.cubicTo(xVal, yVal, xVal - xFactor * scale1, yVal,
        xVal - scale1 * xFactor, yVal + yFactor * scale1);
    xVal = xVal - scale1 * xFactor;
    yVal = yVal + scale1 * yFactor;
    double scale2 = 1.2;
    path.cubicTo(xVal, yVal, xVal, yVal + yFactor * scale2,
        xVal + xFactor * scale2, yVal + yFactor * scale2);
    xVal = xVal + xFactor * scale2;
    yVal = yVal + yFactor * scale2;

    scale = 1.6;

    path.cubicTo(xVal, yVal, xVal + xFactor * scale, yVal,
        xVal + xFactor * scale, yVal + yFactor * scale);
    xVal = xVal + xFactor * scale;
    yVal = yVal + yFactor * scale;

    // TODO: Need to recreate a better later.
    // First point in curve
    // double test = 2.2;
    // path.cubicTo(xVal, yVal, xVal, yVal + yFactor * test, xVal - xFactor * test,
    //     yVal + yFactor * test);
    // xVal = xVal - xFactor * test;
    // yVal = yVal + yFactor * test;

    // test = 1;
    // path.cubicTo(xVal, yVal, xVal - xFactor * test, yVal, xVal - test * xFactor,
    //     yVal + yFactor * test);
    // xVal = xVal - test * xFactor;
    // yVal = yVal + test * yFactor;

    // path.cubicTo(xVal, yVal, xVal, yVal + yFactor * test, xVal + xFactor * test,
    //     yVal + yFactor * test);
    // xVal = xVal + xFactor * test;
    // yVal = yVal + yFactor * test;

    // test = 2.2;

    // path.cubicTo(xVal, yVal, xVal + xFactor * test, yVal, xVal + xFactor * test,
    //     yVal + yFactor * test);
    // xVal = xVal + xFactor * test;
    // yVal = yVal + yFactor * test;

    path.lineTo(xVal, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}