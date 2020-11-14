import 'package:artstore/Drawer/Payment/creditCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardDetails extends StatefulWidget {
  final FirebaseUser firebaseUser;

  CardDetails({this.firebaseUser});

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  List<Color> colors = [
    Colors.indigo[800],
    Colors.green[400],
    Colors.grey[400],
    Colors.deepPurple[400],
    Colors.indigo[800],
    Colors.green[400],
    Colors.grey[400],
    Colors.deepPurple[400],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Payment Methods",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
            height: 900,
            width: 500,
            color: Colors.blue[800],
            child: Container(
                child: Stack(children: <Widget>[
              Positioned(
                  top: 230,
                  child: Container(
                    height: 900,
                    width: 415,
                    decoration: new BoxDecoration(
                        color: Colors.white70.withOpacity(0.91),
                        //new Color.fromRGBO(255, 0, 0, 0.0),
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0))),
                  )),
              Positioned(
                top: 120,
                left: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreditCard(
                                  firebaseUser: widget.firebaseUser,
                                )));
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        //new Color.fromRGBO(255, 0, 0, 0.0),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25.0),
                        )),
                    height: 160,
                    width: 80,
                    child: Icon(
                      Icons.add,
                      color: Colors.indigo,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 120,
                  left: 97,
                  child: Container(
                      height: 160,
                      width: 310,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('users')
                            .document(widget.firebaseUser.uid)
                            .collection("User_Data")
                            .document("Payment_Details")
                            .collection("Card")
                            .snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? Container(
                                  height: 160,
                                  width: 300,
                                  child: PageView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      controller:
                                          PageController(viewportFraction: 0.9),
                                      itemBuilder: (_, index) {
                                        return buildpageviewdetails(
                                            context,
                                            snapshot.data.documents[index],
                                            index);
                                      }),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(212, 20, 15, 1.0),
                                    ),
                                  ),
                                );
                        },
                      ))),
              Positioned(
                top: 320,
                left: 45,
                child: Container(
                  height: 20,
                  width: 200,
                  child: Text(
                    "Other Payment Methods",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.7),
                        fontSize: 17.0),
                  ),
                ),
              ),
              Positioned(top: 350, left: 20, child: middlePart()),
              Positioned(
                bottom: 0.1,
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.indigo[800],
                      //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(40.0))),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        left: 30,
                        child: Container(
                          height: 50,
                          width: 250,
                          child: Text(
                            "Rs.25,000",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 30,
                        child: Container(
                          height: 50,
                          width: 250,
                          child: Text(
                            "View Details",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 28,
                        right: 30,
                        child: Container(
                            height: 50,
                            width: 120,
                            child: FlatButton(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Pay Now",
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.indigo,
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {},
                            )),
                      ),
                    ],
                  ),
                ),
                height: 100,
                width: 412,
              ),
            ]))));
  }

  Widget buildpageviewdetails(
      BuildContext context, DocumentSnapshot documentSnapshot, index) {
    return GestureDetector(
      onLongPress: () {
        _showMyDialog(index);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: colors[index],
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Image.asset("img/master.png")),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 12.0,
                      ),
                      child: Text(
                        documentSnapshot["card_expDate"] ?? "",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 25),
                  height: 50,
                  child: Text(
                    documentSnapshot["card_Number"] ?? "",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  )),
              Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          documentSnapshot["card_Holder_Name"] ?? "",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 12.0,
                        ),
                        child: Text(
                          "Credit card",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget middlePart() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "img/card.png",
                  filterQuality: FilterQuality.high,
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Credit/Debit Card",
                  style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 50,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "img/computer.png",
                  filterQuality: FilterQuality.high,
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Net Banking",
                  style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 50,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "img/google.png",
                  filterQuality: FilterQuality.high,
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Google Wallet",
                  style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 50,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "img/unnamed.png",
                  filterQuality: FilterQuality.high,
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "E-sewa",
                  style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 50,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "img/khal.png",
                  filterQuality: FilterQuality.high,
                  height: 60,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Khalti",
                  style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void delete(int index) async {
    CollectionReference col = Firestore.instance
        .collection('users')
        .document(widget.firebaseUser.uid)
        .collection("User_Data")
        .document("Payment_Details")
        .collection("Card");
    QuerySnapshot q = await col.getDocuments();
    q.documents[index].reference.delete();
  }

  Future<void> _showMyDialog(int index) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Card'),
            content: SingleChildScrollView(
                child: Text("Are you sure you want to delete the card?")),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  delete(index);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
