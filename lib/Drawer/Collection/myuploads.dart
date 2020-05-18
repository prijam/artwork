import 'package:artstore/CustomWidget/splashScreen.dart';
import 'package:artstore/Drawer/Collection/uppload.dart';
import 'package:artstore/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyUpload extends StatefulWidget {
  final FirebaseUser firebaseUser;

  MyUpload({this.firebaseUser});

  @override
  _MyUploadState createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> with TickerProviderStateMixin {
  var timeStatus;
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getTime() {
    DateTime now1 = DateTime.now();
    if (now1.hour < 12 && now1.hour >= 0) {
      timeStatus = 'Good Morning';
    } else if (now1.hour >= 12 && now1.hour < 18) {
      timeStatus = 'Good Afternoon';
    } else if (now1.hour >= 18 && now1.hour < 21) {
      timeStatus = 'Good Evening';
    } else {
      timeStatus = 'Good Night';
    }
    return timeStatus;
  }

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
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Upload(
                          firebaseUser: widget.firebaseUser,
                        )));
          },
          child: Icon(
            Icons.cloud_upload,
            color: Colors.green,
            size: 45.0,
          ),
        ),
        body: Container(
          height: 810,
          width: 500,
          child: Stack(
            children: <Widget>[
              user(),
              Positioned(top: 150, child: tabbar()),
              Positioned(top: 80, left: 1, child: tabview()),
//            uploads(),
            ],
          ),
        ));
  }

  Widget user() {
    return Container(
        margin: EdgeInsets.only(left: 30, top: 1),
        height: 100,
        width: 450,
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(widget.firebaseUser.uid)
              .snapshots(),
          builder: (_, snapshot) {
            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        getTime(),
                        style: TextStyle(
                            fontFamily: 'font2',
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data['firstName'],
                        style: TextStyle(
                            fontFamily: 'font1',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }

  Widget tabbar() {
    return Container(
      height: 450,
      width: 60,
      child: RotatedBox(
        quarterTurns: 11,
        child: DefaultTabController(
          length: 4,
          child: TabBar(
            isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            labelColor: Colors.black,
            indicatorColor: Colors.white,
            controller: _tabController,
            unselectedLabelColor: Colors.grey.withOpacity(0.4),
            tabs: <Widget>[
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Art',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Craft',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Paint',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Illustration',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabview() {
    return Container(
      width: 350,
      margin: EdgeInsets.only(left: 60),
      height: 730.0,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          artTab(),
          craftTab(),
          paintTab(),
          illustrationTab(),
        ],
      ),
    );
  }

  Widget artTab() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid)
          .collection("User_Data")
          .document("Upload")
          .collection("Collection")
          .where("itemType", isEqualTo: "Art")
          .snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(right: 5.0),
                height: DeviceSize.blockSizeVertical * 78.8,
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int i) {
                      String price = snapshot.data.documents[i]["price"];
                      return Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          height: 230,
                          width: 250,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                left: 22,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    child: Image.network(
                                      snapshot.data.documents[i]["itemImage"],
                                      height: 130,
                                      width: 290,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 65,
                                left: 22,
                                child: Container(
                                  margin: EdgeInsets.only(right: 29, top: 5),
                                  height: 20,
                                  width: 254,
                                  child: Text(
                                    snapshot.data.documents[i]["title"],
                                    style: TextStyle(fontFamily: "font2"),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 22,
                                child: Container(
                                  margin: EdgeInsets.only(right: 80, top: 5),
                                  height: 60,
                                  width: 200,
                                  child: Text(
                                    snapshot.data.documents[i]["description"],
                                    style: TextStyle(
                                        fontFamily: "font1",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 1,
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  child: Text(
                                    price.replaceAllMapped(reg, mathFunc),
                                    style: TextStyle(
                                        fontFamily: "font2", color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : Center(
                child: Container(),
              );
      },
    );
  }

  Widget craftTab() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid)
          .collection("User_Data")
          .document("Upload")
          .collection("Collection")
          .where("itemType", isEqualTo: "Craft")
          .snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(right: 5.0),
                height: DeviceSize.blockSizeVertical * 78.8,
                child: Container(
                  child: snapshot.data.documents.length != 0
                      ? ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int i) {
                            String price = snapshot.data.documents[i]["price"];
                            return Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                height: 230,
                                width: 250,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 10,
                                      left: 22,
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.network(
                                            snapshot.data.documents[i]
                                                ["itemImage"],
                                            height: 130,
                                            width: 290,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 65,
                                      left: 22,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(right: 29, top: 5),
                                        height: 20,
                                        width: 254,
                                        child: Text(
                                          snapshot.data.documents[i]["title"],
                                          style: TextStyle(fontFamily: "font2"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 22,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(right: 80, top: 5),
                                        height: 60,
                                        width: 200,
                                        child: Text(
                                          snapshot.data.documents[i]
                                              ["description"],
                                          style: TextStyle(
                                              fontFamily: "font1",
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 1,
                                      child: Container(
                                        height: 20,
                                        width: 80,
                                        child: Text(
                                          price.replaceAllMapped(reg, mathFunc),
                                          style: TextStyle(
                                              fontFamily: "font2",
                                              color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Container(
                          margin: EdgeInsets.only(bottom: 150),
                          child: Image.asset(
                            "img/emp.png",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                          )),
                ))
            : Center(
                child: Container(),
              );
      },
    );
  }

  Widget paintTab() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid)
          .collection("User_Data")
          .document("Upload")
          .collection("Collection")
          .where("itemType", isEqualTo: "Paint")
          .snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(right: 5.0),
                height: DeviceSize.blockSizeVertical * 78.8,
                child: snapshot.data.documents.length != 0
                    ? ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int i) {
                          String price = snapshot.data.documents[i]["price"];
                          return Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              height: 230,
                              width: 250,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 10,
                                    left: 22,
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Image.network(
                                          snapshot.data.documents[i]
                                              ["itemImage"],
                                          height: 130,
                                          width: 290,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 65,
                                    left: 22,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 29, top: 5),
                                      height: 20,
                                      width: 254,
                                      child: Text(
                                        snapshot.data.documents[i]["title"],
                                        style: TextStyle(fontFamily: "font2"),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 22,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 80, top: 5),
                                      height: 60,
                                      width: 200,
                                      child: Text(
                                        snapshot.data.documents[i]
                                            ["description"],
                                        style: TextStyle(
                                            fontFamily: "font1",
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.grey.withOpacity(0.8)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 1,
                                    child: Container(
                                      height: 20,
                                      width: 80,
                                      child: Text(
                                        price.replaceFirstMapped(reg, mathFunc),
                                        style: TextStyle(
                                            fontFamily: "font2",
                                            color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        margin: EdgeInsets.only(bottom: 150),
                        child: Image.asset(
                          "img/emp.png",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                        )),
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

  Widget illustrationTab() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid)
          .collection("User_Data")
          .document("Upload")
          .collection("Collection")
          .where("itemType", isEqualTo: "Illustration")
          .snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(right: 5.0),
                height: DeviceSize.blockSizeVertical * 78.8,
                child: snapshot.data.documents.length != 0
                    ? ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int i) {
                          String price = snapshot.data.documents[i]["price"];
                          return Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              height: 230,
                              width: 250,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 10,
                                    left: 22,
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Image.network(
                                          snapshot.data.documents[i]
                                              ["itemImage"],
                                          height: 130,
                                          width: 290,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 65,
                                    left: 22,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 29, top: 5),
                                      height: 20,
                                      width: 254,
                                      child: Text(
                                        snapshot.data.documents[i]["title"],
                                        style: TextStyle(fontFamily: "font2"),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 22,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 80, top: 5),
                                      height: 60,
                                      width: 200,
                                      child: Text(
                                        snapshot.data.documents[i]
                                            ["description"],
                                        style: TextStyle(
                                            fontFamily: "font1",
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.grey.withOpacity(0.8)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 1,
                                    child: Container(
                                      height: 20,
                                      width: 80,
                                      child: Text(
                                        price.replaceFirstMapped(reg, mathFunc),
                                        style: TextStyle(
                                            fontFamily: "font2",
                                            color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        margin: EdgeInsets.only(bottom: 150),
                        child: Image.asset(
                          "img/emp.png",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                        )),
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
}
