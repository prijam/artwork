import 'package:artstore/HomePage/TrendingSeeMore.dart';
import 'package:artstore/HomePage/bestSeliignSeeMore.dart';
import 'package:artstore/Profile/profile.dart';
import 'package:artstore/details/artdetails.dart';
import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/firebbstore.dart';
import 'package:artstore/firebaseHandler/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Drawer/drawer.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser firebaseUser;

  HomePage({this.firebaseUser});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  firestore fire = firestore();

  @override
  void initState() {
    super.initState();
    HomePage();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark
    ));
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: drawer(
        firebaseUser: widget.firebaseUser,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 890,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 2.0,
                ),
                header(),
                SizedBox(
                  height: 10.0,
                ),
                Search(),
                SizedBox(
                  height: 20.0,
                ),
                firstTab(),
                pageview(),
                SizedBox(
                  height: 10.0,
                ),
                secondTab(),
                tabbar(),
                tabview()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: InkWell(
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Icon(Icons.sort)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Art Store",
              style: TextStyle(
                  fontFamily: 'font', letterSpacing: 0.3, fontSize: 22.0),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(
                              firebaseUser: widget.firebaseUser,
                            )));
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: StreamBuilder<User>(
                    stream: Auth.getUser(widget.firebaseUser.uid),
                    builder: (_, snapshot) {
                      return snapshot.hasData
                          ? CircleAvatar(
                              radius: 17.0,
                              backgroundImage:
                                  NetworkImage(snapshot.data.profilePictureURL),
                              backgroundColor: Colors.transparent,
                            )
                          : Center(child: Container());
                    },
                  )))
        ]);
  }

  Widget Search() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelText: "Search art, artist, color. . .",
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.3),
                ))));
  }

  Widget firstTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          width: 160,
          height: 40,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Image.asset(
                  'img/int.png',
                  filterQuality: FilterQuality.high,
                  color: Colors.black,
                  height: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "Best Selling",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.black.withOpacity(0.7)),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SellingSeeMore()));
          },
          child: Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Text(
              "See all",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }

  Widget secondTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          width: 160,
          height: 40,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Image.asset(
                  'img/int.png',
                  filterQuality: FilterQuality.high,
                  color: Colors.black,
                  height: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "Trending",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.black.withOpacity(0.7)),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TrendingSeeMore()));
          },
          child: Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Text(
              "See all",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }

  Widget pageview() {
    return Container(
        height: 330,
        width: 500,
        child: StreamBuilder(
          stream: Firestore.instance.collection('bestsellings').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? PageView.builder(
                    controller: PageController(viewportFraction: 0.73),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return buildpageviewdetails(
                          context, snapshot.data.documents[index]);
                    })
                : Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(212, 20, 15, 1.0),
                      ),
                    ),
                  );
          },
        ));
  }

  Widget buildpageviewdetails(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                post: documentSnapshot,
                              )));
                },
                child: Container(
                  height: 170,
                  width: 500,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, right: 15, left: 15, bottom: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: "img/home.gif",
                          image: documentSnapshot["img"],
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 20,
                      child: Text(
                        documentSnapshot["title"] ?? "",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                        left: 20,
                        top: 27,
                        child: Text(
                          "Atrist : ",
                          style: TextStyle(color: Colors.grey),
                        )),
                    Positioned(
                        left: 68,
                        top: 27.5,
                        child: Text(
                          documentSnapshot["artist"] ?? "",
                          style: TextStyle(color: Colors.grey),
                        )),
                    Positioned(
                        left: 238,
                        top: 10,
                        child: Text(
                          "Rs",
                          style: TextStyle(color: Colors.grey),
                        )),
                    Positioned(
                        left: 225,
                        top: 30,
                        child: Container(
                          width: 70,
                          child: Text(
                            documentSnapshot["price"] ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 250,
                height: 35,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Buy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      child: Container(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1.2,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 80,
                        child: Icon(
                          Icons.star,
                          color: Colors.grey,
                        )),
                    Positioned(
                        left: 110,
                        top: 5,
                        child: Text(
                          documentSnapshot["rating"] ?? "",
                          style: TextStyle(color: Colors.grey),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                  width: 250,
                  height: 35,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 5,
                          left: 5,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.grey,
                            size: 18.0,
                          )),
                      Positioned(
                          left: 35,
                          top: 5,
                          child: Text(
                            documentSnapshot["sell"] ?? "",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )),
                      Positioned(
                          left: 57,
                          top: 6,
                          child: Text(
                            "Purchase",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )),
                    ],
                  ))
            ],
          )),
    );
  }

  Widget tabbar() {
    return Padding(
      padding: EdgeInsets.only(right: 110.0),
      child: DefaultTabController(
        length: 4,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          indicator:
              CircleTabIndicator(color: Colors.deepOrangeAccent, radius: 3),
          tabs: <Widget>[
            Tab(
              child: Text('Art',
                  style: TextStyle(
                      color: _tabController.index == 0
                          ? Colors.deepOrangeAccent
                          : Colors.grey)),
            ),
            Tab(
              child: Text('Paint',
                  style: TextStyle(
                      color: _tabController.index == 1
                          ? Colors.deepOrangeAccent
                          : Colors.grey)),
            ),
            Tab(
              child: Text('Craft',
                  style: TextStyle(
                      color: _tabController.index == 2
                          ? Colors.deepOrangeAccent
                          : Colors.grey)),
            ),
            Tab(
              child: Text('Illustration',
                  style: TextStyle(
                      color: _tabController.index == 3
                          ? Colors.deepOrangeAccent
                          : Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabview() {
    return Container(
      height: 260.0,
      child: new TabBarView(
        controller: _tabController,
        children: <Widget>[arttab(), painttab(), crafttab(), illutab()],
      ),
    );
  }

  Widget arttab() {
    return StreamBuilder(
      stream: Firestore.instance.collection('art').snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return artlayout(context, snapshot.data.documents[index]);
                })
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

  Widget artlayout(BuildContext context, DocumentSnapshot documentSnapshot) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0, top: 18),
            child: Container(
              height: 60,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FadeInImage.assetNetwork(
                  placeholder: "img/home.gif",
                  image: documentSnapshot["img"],
                  fadeInCurve: Curves.easeIn,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18, left: 15),
            child: Container(
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      documentSnapshot["title"] ?? "",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    documentSnapshot["arist"] ?? "",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
              height: 50,
              width: 75,
              child: Column(
                children: <Widget>[
                  Text("Rs"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    documentSnapshot["price"] ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget crafttab() {
    return StreamBuilder(
      stream: Firestore.instance.collection('craft').snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return artlayout(context, snapshot.data.documents[index]);
                })
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

  Widget craftlayout(BuildContext context, DocumentSnapshot documentSnapshot) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0, top: 18),
            child: Container(
              height: 60,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FadeInImage.assetNetwork(
                  placeholder: "img/home.gif",
                  image: documentSnapshot["img"],
                  fadeInCurve: Curves.easeIn,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18, left: 15),
            child: Container(
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      documentSnapshot["title"] ?? "",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    documentSnapshot["arist"] ?? "",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
              height: 50,
              width: 75,
              child: Column(
                children: <Widget>[
                  Text("Rs"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    documentSnapshot["price"] ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget illutab() {
    return StreamBuilder(
      stream: Firestore.instance.collection('illu').snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return illuview(context, snapshot.data.documents[index]);
                })
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

  Widget illuview(BuildContext context, DocumentSnapshot documentSnapshot) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0, top: 18),
            child: Container(
              height: 60,
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "img/home.gif",
                    image: documentSnapshot["img"],
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18, left: 15),
            child: Container(
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      documentSnapshot["title"] ?? "",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    documentSnapshot["arist"] ?? "",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
              height: 50,
              width: 75,
              child: Column(
                children: <Widget>[
                  Text("Rs"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    documentSnapshot["price"] ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget painttab() {
    return StreamBuilder(
      stream: Firestore.instance.collection('paint').snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return paintView(context, snapshot.data.documents[index]);
                })
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

  Widget paintView(BuildContext context, DocumentSnapshot documentSnapshot) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0, top: 18),
            child: Container(
              height: 60,
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "img/home.gif",
                    image: documentSnapshot["img"],
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18, left: 15),
            child: Container(
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      documentSnapshot["title"] ?? "",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    documentSnapshot["arist"] ?? "",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
              height: 50,
              width: 75,
              child: Column(
                children: <Widget>[
                  Text("Rs"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    documentSnapshot["price"] ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
