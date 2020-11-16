import 'package:artstore/firebaseHandler/firebbstore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Details extends StatefulWidget {
  final DocumentSnapshot post;
  final bool added;
  final String uid;

  Details({this.post, this.added, this.uid});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  firestore fire = firestore();
  bool addded1 = false;

  @override
  void initState() {
    print(widget.added);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      key: _scaffoldkey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Exhibition",
          style: TextStyle(color: Colors.white70),
        ),
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
              decoration:
                  BoxDecoration(color: Colors.blueGrey, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1020,
          child: Stack(
            children: <Widget>[
              image(),
              Positioned(top: 350, child: detailsview())
            ],
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      height: 380,
      width: 500,
      child: Image.network(
        widget.post.data["img"],
        filterQuality: FilterQuality.high,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget detailsview() {
    return Container(
      height: 700,
      width: 411.5,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: <Widget>[userdetail(), details()],
      ),
    );
  }

  Widget userdetail() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(widget.post.data["userimg"]),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 22,
                      ),
                      Container(
                        width: 145,
                        height: 20,
                        child: Text(
                          widget.post.data["artist"] ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.post.data["type"] ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.withOpacity(0.7),
                            letterSpacing: 0.4,
                            fontFamily: 'font3',
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // addtoCart
          //     ? RaisedButton(
          //         elevation: 0.0,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5.0),
          //             side: BorderSide(color: Colors.red)),
          //         color: Colors.green,
          //         onPressed: () {},
          //         child: Text(
          //           "Added to Cart",
          //           style: TextStyle(
          //               color: Colors.white, fontWeight: FontWeight.w600),
          //         ),
          //       )
          widget.added || addded1
              ? RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.green)),
                  color: Colors.green,
                  onPressed: () {
                    _scaffoldkey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                      elevation: 6.0,
                      behavior: SnackBarBehavior.floating,
                      content: Row(
                        children: <Widget>[
                          Icon(Icons.playlist_add),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Text("Already added to Cart."),
                          )
                        ],
                      ),
                    ));
                  },
                  child: Text(
                    "Added to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0),
                  ),
                )
              : RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.red)),
                  color: Colors.deepOrange,
                  onPressed: () {
                    addtocart();
                    setState(() {
                      addded1 = true;
                    });
                  },
                  child: Text(
                    "Add to cart",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
        ],
      ),
    );
  }

  void addtocart() {
    Map<String, dynamic> regionData = new Map<String, dynamic>();
    DocumentReference documentReference = Firestore.instance
        .collection("users")
        .document(widget.uid)
        .collection("User_Data")
        .document("My_Cart")
        .collection("OrderItems")
        .document(widget.post.documentID);
    documentReference.setData({
      "title": widget.post.data["title"],
      "price": widget.post.data["price"],
      "itemImage": widget.post.data["img"],
      "itemType": widget.post.data["arttype"],
    });
  }

  Widget details() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27), topRight: Radius.circular(30))),
      height: 570,
      width: 411.5,
      child: Column(
        children: <Widget>[
          titletab(),
          overview(),
          about(),
          people(),
          SizedBox(
            height: 20,
          ),
          similarTitle(),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 225,
            width: 425,
            child: similarWork(),
          )
//          similarWork()
        ],
      ),
    );
  }

  Widget titletab() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 75,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30),
            height: 50,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.post.data["title"] ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                      fontFamily: 'font2',
                      fontSize: 18.0),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.post.data["arttype"] ?? "",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 120,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 25.0,
                  top: 8.0,
                  child: Text(
                    "Rs",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 12.0,
                  child: Text(
                    widget.post.data["price"] ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget overview() {
    return Container(
      margin: EdgeInsets.only(right: 135),
      height: 40,
      width: 200,
      child: Row(
        children: <Widget>[
          Text(
            "Overview",
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                fontSize: 16.0),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 25,
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 0.5,
            ),
          ),
          SizedBox(
            width: 13,
          ),
          Text(
            "Review",
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget about() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 90,
      width: 330,
      child: Text(
        widget.post.data["about"] ?? "",
        textAlign: TextAlign.start,
        style: TextStyle(
            letterSpacing: 0.3,
            fontSize: 15.0,
            color: Colors.black.withOpacity(0.7)),
      ),
    );
  }

  Widget people() {
    return Padding(
      padding: const EdgeInsets.only(right: 200.0),
      child: Container(
        height: 40,
        width: 150,
        child: Stack(
          children: <Widget>[
            Container(
                child: new CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(widget.post.data["userimg1"]),
                  backgroundColor: Colors.transparent,
                ),
                width: 36.0,
                height: 36.0,
                padding: const EdgeInsets.all(2.0),
                // borde width
                decoration: new BoxDecoration(
                  color: const Color(0xFFFFFFFF), // border color
                  shape: BoxShape.circle,
                )),
            Positioned(
              left: 25,
              child: Container(
                  child: new CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(widget.post.data["userimg2"]),
                    backgroundColor: Colors.transparent,
                  ),
                  width: 36.0,
                  height: 36.0,
                  padding: const EdgeInsets.all(2.0),
                  // borde width
                  decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF), // border color
                    shape: BoxShape.circle,
                  )),
            ),
            Positioned(
              left: 52,
              child: Container(
                  child: new CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(widget.post.data["userimg3"]),
                    backgroundColor: Colors.transparent,
                  ),
                  width: 36.0,
                  height: 36.0,
                  padding: const EdgeInsets.all(2.0),
                  // borde width
                  decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF), // border color
                    shape: BoxShape.circle,
                  )),
            ),
            Positioned(
              left: 94,
              top: 10,
              child: Text(
                widget.post.data["follow"] ?? "",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget similarTitle() {
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
                  "Similar Works",
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
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => SellingSeeMore()));
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

  Widget similarWork() {
    return Container(
      child: StreamBuilder(
          stream: Firestore.instance.collection('similarwork').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ));
            } else {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    return similarwirkopage(
                        context, snapshot.data.documents[index]);
                  });
            }
          }),
    );
  }

  Widget similarwirkopage(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0),
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
              padding: EdgeInsets.only(top: 5, left: 15),
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
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                height: 50,
                width: 60,
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
      ),
    );
  }
}
