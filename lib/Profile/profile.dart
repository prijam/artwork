import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfile extends StatefulWidget {
  final FirebaseUser firebaseUser;

  UserProfile({this.firebaseUser});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _mainScaffoldState =
      new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final _profileKey = new GlobalKey<FormState>();
  String newName;
  String newNumber;
  final nameHolder = TextEditingController();
  final numberHolder = TextEditingController();
  File _image;

  Future _saveName() async {
    if (newName != null) {
      final DocumentReference doc = Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid);
      Map<String, String> data = <String, String>{
        "firstName": newName,
      };
      doc.updateData(data).whenComplete(() {
        nameHolder.clear();
        _scaffoldState.currentState.showSnackBar(snackbar1());
      }).catchError((e) {
        _scaffoldState.currentState.showSnackBar(SnackBar(content: Text(e)));
      });
    } else {
      _scaffoldState.currentState.showSnackBar(errorbar());
    }
  }

  Future _saveNumber() async {
    if (newNumber != null) {
      final DocumentReference doc = Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid);
      Map<String, String> data = <String, String>{
        "contactNumber": newNumber,
      };
      doc.updateData(data).whenComplete(() {
        numberHolder.clear();
        _scaffoldState.currentState.showSnackBar(snackbar2());
      }).catchError((e) {
        _scaffoldState.currentState.showSnackBar(SnackBar(content: Text(e)));
      });
    } else {
      _scaffoldState.currentState.showSnackBar(errorbar());
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _image = image;
              print(_image);
            }));
  }

  Future uploadPic() async {
    if (_image != null) {
      final DocumentReference doc = Firestore.instance
          .collection("users")
          .document(widget.firebaseUser.uid);
      String fileName = basename(_image.path);
      StorageReference fireBaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = fireBaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      Map<String, String> data = <String, String>{
        "profilePictureURL": downloadUrl,
        "photoUrlFile": fileName,
      };
      doc.updateData(data).whenComplete(() {
        _mainScaffoldState.currentState.showSnackBar(picUpdated());
      }).catchError((e) {
        _mainScaffoldState.currentState.showSnackBar(errorbar());
      });
    }
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _mainScaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData.fallback(),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white.withOpacity(1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: 830,
              child: Column(
                children: <Widget>[
                  userInfo(),
                  SizedBox(
                    height: 40.0,
                  ),
                  div(),
                  SizedBox(
                    height: 20.0,
                  ),
                  profileS(),
                  SizedBox(
                    height: 30.0,
                  ),
                  YourData(context),
                  SizedBox(
                    height: 20.0,
                  ),
                  div1(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Privacy(),
                  SizedBox(
                    height: 20.0,
                  ),
                  div1(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Notifi(),
                  SizedBox(
                    height: 30.0,
                  ),
                  div(),
                  SizedBox(
                    height: 20.0,
                  ),
                  card(),
                  SizedBox(
                    height: 30.0,
                  ),
                  paymentSe(),
                  SizedBox(
                    height: 15.0,
                  ),
                  div1(),
                  SizedBox(
                    height: 15.0,
                  ),
                  paymentpro(),
                  SizedBox(
                    height: 35.0,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget userInfo() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(widget.firebaseUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(212, 20, 15, 1.0),
                ),
              ),
            );
          } else {
            var name = snapshot.data['firstName'];
            var email = snapshot.data['email'];
            var number = snapshot.data['contactNumber'];
            var customPhoto = snapshot.data['profilePictureURL'];
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(_image),
                          )
                        : (_image == null && customPhoto != null)
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(customPhoto),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(customPhoto),
                              ),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.save,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                if (_image == null) {
                                  Scaffold.of(context).showSnackBar(noPhoto());
                                } else {
                                  uploadPic();
                                  Scaffold.of(context).showSnackBar(wait());
                                }
                              },
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 77),
                  width: 250,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      name ?? "Display Name",
                      style: TextStyle(
                        fontFamily: 'font2',
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 24.0,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 110),
                  width: 250,
                  child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text(
                      email,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 83, top: 5),
                  width: 250,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              number ?? "",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.6),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            );
          }
        });
  }

  Widget div() {
    return Container(
      width: 500,
      child: Divider(
        color: Colors.grey.withOpacity(0.3),
        thickness: 3,
      ),
    );
  }

  Widget profileS() {
    return Container(
      width: 370,
      child: Text(
        "Profile settings",
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'font2',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3),
      ),
    );
  }

  Widget card() {
    return Container(
      width: 370,
      child: Text(
        "Card settings",
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontFamily: 'font2',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3),
      ),
    );
  }

  Widget YourData(BuildContext context) {
    return InkWell(
      onTap: () {
        _settingModalBottomSheet(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green[700], shape: BoxShape.circle),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          Container(
            width: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Your data",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Update and modify your profile",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'font2',
                      fontSize: 13.0,
                      letterSpacing: 0.5,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0, top: 15),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blueGrey,
            ),
          )
        ],
      ),
    );
  }

  Widget div1() {
    return Container(
      width: 380,
      child: Divider(
        color: Colors.grey,
      ),
    );
  }

  Widget Privacy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.blue[700], shape: BoxShape.circle),
            child: Icon(
              Icons.lock,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        Container(
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Privacy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Change email and password",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'font2',
                    fontSize: 13.0,
                    letterSpacing: 0.5,
                    color: Colors.grey),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 18.0, top: 15),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  Widget Notifi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange[700], shape: BoxShape.circle),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        Container(
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Notifications",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Change notification settings",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'font2',
                    fontSize: 13.0,
                    letterSpacing: 0.5,
                    color: Colors.grey),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 18.0, top: 15),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  Widget paymentSe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.red[700], shape: BoxShape.circle),
            child: Icon(
              Icons.monetization_on,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        Container(
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Payment settings",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Update your payments settings",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'font2',
                    fontSize: 13.0,
                    letterSpacing: 0.5,
                    color: Colors.grey),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 18.0, top: 15),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  Widget paymentpro() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.blue[300], shape: BoxShape.circle),
            child: Icon(
              Icons.offline_pin,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        Container(
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Set your payment protection",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Update your payment protection",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'font2',
                    fontSize: 13.0,
                    letterSpacing: 0.5,
                    color: Colors.grey),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 18.0, top: 15),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            height: 450,
            child: Scaffold(
              key: _scaffoldState,
              body: Container(
                color: Color(0XFF737373),
                height: 450,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                      )),
                  child: Form(
                    key: _profileKey,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 450,
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 30),
                                child: Text(
                                  "Update and modify your profile",
                                  style: TextStyle(
                                      color: Colors.green,
                                      letterSpacing: 0.3,
                                      fontFamily: 'font2',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 20),
                                child: Text(
                                  "Full Name",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                              ),
                              namefield(),
                              InkWell(
                                onTap: () {
                                  _saveName();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, right: 340),
                                  child: Container(
                                      height: 20,
                                      width: 50,
                                      child: Image.asset("img/interfaces.png")),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 20),
                                child: Text(
                                  "Contact Number",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                              ),
                              contactNumber(),
                              InkWell(
                                onTap: () {
                                  _saveNumber();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, right: 340),
                                  child: Container(
                                      height: 20,
                                      width: 50,
                                      child: Image.asset("img/interfaces.png")),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget namefield() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            onSubmitted: (name) {
              newName = name;
            },
            controller: nameHolder,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.green,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.green)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.3),
                ))));
  }

  Widget contactNumber() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            controller: numberHolder,
            onSubmitted: (number) {
              newNumber = number;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.green,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.green)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.3),
                ))));
  }

  Widget snackbar1() {
    return SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.thumb_up,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Name updated"),
          )
        ],
      ),
    );
  }

  Widget snackbar2() {
    return SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.thumb_up,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Contact Number updated"),
          )
        ],
      ),
    );
  }

  Widget errorbar() {
    return SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Field must not be empty"),
          )
        ],
      ),
    );
  }

  Widget noPhoto() {
    return SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.photo,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("No Photo Selected"),
          )
        ],
      ),
    );
  }

  Widget picUpdated() {
    return SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.photo,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Profile Picture Updated"),
          )
        ],
      ),
    );
  }

  Widget wait() {
    return SnackBar(
      backgroundColor: Colors.orangeAccent,
      duration: Duration(seconds: 2),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.sentiment_satisfied,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Uploading..."),
          )
        ],
      ),
    );
  }
}
