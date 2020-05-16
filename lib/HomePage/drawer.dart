import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/firebaseHandler/userModel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  final FirebaseUser firebaseUser;

  drawer({this.firebaseUser});

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          Container(
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 50),
                            width: 150,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.notifications_none,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 3, right: .5),
                                  width: 100,
                                  height: 20,
                                  child: Text(
                                    "Notifications",
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
                          SizedBox(
                            height: 40,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            }));
  }

  void _logOut() async {
    Auth.signOut();
  }
}
