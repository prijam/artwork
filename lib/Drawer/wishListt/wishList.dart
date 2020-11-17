import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  final String uid;

  WishList({this.uid});

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.0,
        title: Text(
          "My WishList",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: body(),
    );
  }

  Widget body() {
    return StreamBuilder(
        stream: Firestore()
            .collection("users")
            .document(widget.uid)
            .collection("User_Data")
            .document("Wish_List")
            .collection("wish_items")
            .snapshots(),
        builder: (cntx, snap) {
          if (snap.hasData) {
            return Container(
              height: 1000,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: snap.data.documents.length != 0
                    ? ListView.builder(
                        itemCount: snap.data.documents.length,
                        itemBuilder: (context, index) {
                          print(snap.data.documents.length);
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 5, right: 5),
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  delete(index);
                                  _scaffoldState.currentState
                                      .showSnackBar(remove());
                                } else {
                                  delete(index);
                                  _scaffoldState.currentState
                                      .showSnackBar(remove());
                                }
                              },
                              background: Container(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.white),
                                      Text('Remove from WishList',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              secondaryBackground: Container(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.delete, color: Colors.white),
                                      Text('Remove from WishList',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              child: Card(
                                elevation: 1.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            snap.data.documents[index]
                                                ["itemImage"],
                                            height: 90,
                                            width: 140,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 230,
                                      height: 90,
                                      child: Stack(
                                        children: [
                                          Text(
                                            snap.data.documents[index]["title"],
                                            style: TextStyle(
                                                fontFamily: "font1",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          Positioned(
                                            right: 23.0,
                                            top: 10,
                                            child: Text(
                                              "Rs",
                                              style: TextStyle(
                                                  fontFamily: "font1",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Positioned(
                                              right: 10.0,
                                              top: 30,
                                              child: Text(
                                                snap.data.documents[index]
                                                    ["price"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Positioned(
                                              top: 25,
                                              child: Text(
                                                snap.data.documents[index]
                                                    ["itemType"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  void delete(int index) async {
    CollectionReference col = Firestore.instance
        .collection("users")
        .document(widget.uid)
        .collection("User_Data")
        .document("Wish_List")
        .collection("wish_items");
    print(col.id.length);
    QuerySnapshot q = await col.getDocuments();
    q.documents[index].reference.delete();
  }

  Widget remove() {
    return SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Removed from WishList."),
          )
        ],
      ),
    );
  }
}
