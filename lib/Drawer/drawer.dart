import 'package:artstore/HomePage/noti.dart';
import 'package:artstore/Drawer/Mycart/cart.dart';
import 'package:artstore/Drawer/Notification/NotificationView.dart';
import 'package:artstore/Drawer/Payment/creditCard.dart';
import 'package:artstore/Drawer/Payment/details.dart';
import 'package:artstore/Drawer/wishListt/wishList.dart';
import 'package:artstore/HomePage/home.dart';
import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/userModel.dart';
import 'package:artstore/introScreen/viewPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Collection/firstView.dart';

class HomeDrawer extends StatefulWidget {
  final FirebaseUser firebaseUser;

  HomeDrawer({this.firebaseUser});

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth.getUser(widget.firebaseUser.uid),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return snapshot.hasData
              ? Drawer(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 130),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage(snapshot.data.profilePictureURL),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 8),
                        child: Container(
                          width: 210,
                          child: Text(
                            snapshot.data.firstName ?? "Display Name",
                            style: TextStyle(
                              fontFamily: 'font2',
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 24.0,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 38),
                        child: Container(
                          width: 240,
                          child: Text(
                            snapshot.data.email ?? "demo@example.com",
                            style: TextStyle(
                              fontFamily: 'font2',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.withOpacity(0.7),
                              fontSize: 16.0,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        hoverColor: Colors.grey,
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.dehaze,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 2.0),
                                width: 100,
                                height: 20,
                                child: Text(
                                  "Store",
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Firestore.instance
                              .collection("users")
                              .document(widget.firebaseUser.uid)
                              .collection("User_Data")
                              .document("Payment_Details")
                              .collection("Card")
                              .getDocuments()
                              .asStream()
                              .listen((event) {
                            event.documents.length == 0
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreditCard(
                                              firebaseUser: widget.firebaseUser,
                                            )))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CardDetails(
                                              firebaseUser: widget.firebaseUser,
                                            )));
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.credit_card,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 3, right: 10),
                                width: 100,
                                height: 20,
                                child: Text(
                                  "Payments",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessageList(
                                        firebaseUser: widget.firebaseUser,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 4.8, left: 1),
                                child: Icon(
                                  Icons.message,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                child: Text(
                                  "Messages",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstView(
                                        firebaseUser: widget.firebaseUser,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.filter,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Container(
                                width: 100,
                                height: 20,
                                margin: EdgeInsets.only(right: 2),
                                child: Text(
                                  "Collection",
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WishList(
                                        uid: widget.firebaseUser.uid,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.card_travel,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 3, right: .5),
                                width: 100,
                                height: 20,
                                child: Text(
                                  "WishList",
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyCart(
                                        uid: widget.firebaseUser.uid,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 3, right: .5),
                                width: 100,
                                height: 20,
                                child: Text(
                                  "My Cart",
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationList()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.notifications,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 3, right: .5),
                                width: 100,
                                height: 20,
                                child: Text(
                                  "Notification",
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 50),
                        width: 150,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.settings,
                              color: Colors.grey.withOpacity(0.9),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              margin: EdgeInsets.only(top: 10, right: 4),
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                    color: Colors.grey.withOpacity(0.9)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              _logOut();
                            });
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.red.withOpacity(0.9),
                              ),
                              Container(
                                width: 100,
                                height: 25,
                                margin: EdgeInsets.only(top: 5, right: 4),
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  void _logOut() async {
    Auth.signOut();
  }
}
