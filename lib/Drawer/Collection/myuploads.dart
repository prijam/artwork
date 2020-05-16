
import 'package:artstore/CustomWidget/splashScreen.dart';
import 'package:artstore/Drawer/Collection/uppload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyUpload extends StatefulWidget {
  final FirebaseUser firebaseUser;

  MyUpload({this.firebaseUser});

  @override
  _MyUploadState createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  var timeStatus;

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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "My uploads",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          heroTag: 'fab',
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
        body: Column(
          children: <Widget>[
            user(),
            uploads(),
          ],
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
                            fontFamily: 'font1',
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

  Widget uploads() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid)
          .collection("User_Data")
          .document("Upload")
          .collection("Collection")
          .snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
       return snapshot.hasData
            ? Container(
                height: DeviceSize.blockSizeVertical *78.8,
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: DeviceSize.blockSizeHorizontal * 95,
                              height: DeviceSize.blockSizeVertical * 17,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: DeviceSize.blockSizeVertical * 1.5,
                                    child: Container(
                                      height: DeviceSize.blockSizeVertical * 15,
                                      width:
                                      DeviceSize.blockSizeHorizontal * 60,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Product Title :",style: TextStyle(
                                              color: Colors.grey
                                          ),),
                                          SizedBox(
                                            height:
                                            DeviceSize.blockSizeVertical *
                                                .5,
                                          ),
                                          Container(
                                            width: 100,
                                            height:16,
                                            child: Text(
                                              snapshot.data.documents[i]["title"],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                            DeviceSize.blockSizeVertical *
                                                1,
                                          ),
                                          Text("Description :",style: TextStyle(
                                              color: Colors.grey
                                          ),),
                                          Text(
                                            snapshot.data.documents[i]
                                            ["description"],
                                            maxLines: 3,
                                            style:
                                            TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: DeviceSize.blockSizeHorizontal *3,
                                    top: DeviceSize.blockSizeVertical * 1,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Container(
                                          height:
                                          DeviceSize.blockSizeVertical *
                                              15,
                                          width:    DeviceSize.blockSizeVertical *17,
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "img/load.gif",
                                            image: snapshot.data.documents[i]["itemImage"],
                                            fadeInCurve: Curves.easeIn,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    top: DeviceSize.blockSizeVertical * 13,
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Text("Rs:"+
                                          snapshot.data.documents[i]["price"],
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              width: DeviceSize.blockSizeHorizontal * 95,
                              child: Divider(
                                color: Colors.grey,
                                thickness: DeviceSize.blockSizeVertical * .2,
                              )),
                        ],
                      );
                    }),
              )
            : Center(
                child: Container(),
              );
      },
    );
  }
}
