import 'package:artstore/Drawer/Payment/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'creditCardBack.dart';
import 'creditCardFront.dart';

class CreditCard extends StatefulWidget {
  final FirebaseUser firebaseUser;

  CreditCard({this.firebaseUser});

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String _name = "";
  String _creditCardNumber = "";
  String _securityCode = "";
  String _expDate = "";

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  Future _saveCard() async {
    Firestore.instance
        .collection("users")
        .document(widget.firebaseUser.uid)
        .collection("User_Data")
        .document("Payment_Details")
        .collection("Card")
        .document()
        .setData({
      "card_Holder_Name": _name,
      "card_Number": _creditCardNumber,
      "card_expDate": _expDate,
      "card_CVV": _securityCode
    }).whenComplete(() =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CardDetails(
      firebaseUser: widget.firebaseUser,
    ))));
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

  Widget snackbar1() {
    return SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          Icon(
            Icons.credit_card,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text("Card Added"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[800],
    ));
    return Scaffold(
        key: _scaffoldState,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Add new card",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
              height: 900,
              color: Colors.blue[800],
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 230,

                      child: Container(
                          height: 900,
                          width: 415,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              //new Color.fromRGBO(255, 0, 0, 0.0),
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(40.0),
                                  topRight: const Radius.circular(40.0))),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 130,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 370,
                                  child: Text(
                                    "Card Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                        color: Colors.black.withOpacity(0.6)),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top:15),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(19),
                                      CardNumberInputFormatter(),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _creditCardNumber = value;
                                      });
                                    },
                                    style: TextStyle(color: Colors.black),
                                    decoration: new InputDecoration(
                                        labelStyle: TextStyle(
                                          letterSpacing: 0.8,
                                          color: Colors.grey,
                                        ),
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(35.0),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 0.0),
                                        ))),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  width: 370,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Expiry Date",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 100.0),
                                        child: Text(
                                          "CVV",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                      ),
                                    ],
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 21, top: 15),
                                    child: Container(
                                      width: 150,
                                      child: TextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly,
                                            new LengthLimitingTextInputFormatter(
                                                4),
                                            new CardMonthInputFormatter()
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _expDate = value;
                                            });
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: new InputDecoration(
                                              labelStyle: TextStyle(
                                                letterSpacing: 0.8,
                                                color: Colors.grey,
                                              ),
                                              border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          35.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black)),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.blue,
                                                    width: 0.0),
                                              ))),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 15),
                                    child: Container(
                                      width: 130,
                                      child: TextField(
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              _securityCode = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              cardKey.currentState.toggleCard();
                                            });
                                          },
                                          onTap: () {
                                            setState(() {
                                              cardKey.currentState.toggleCard();
                                            });
                                          },
                                          style: TextStyle(color: Colors.black),
                                          decoration: new InputDecoration(
                                              labelStyle: TextStyle(
                                                letterSpacing: 0.8,
                                                color: Colors.grey,
                                              ),
                                              border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          35.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black)),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.blue,
                                                    width: 0.0),
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                width: 370,
                                child: Text(
                                  "Name on Card",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, right: 15, left: 20),
                                child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _name = value;
                                      });
                                    },
                                    style: TextStyle(color: Colors.black),
                                    decoration: new InputDecoration(
                                        labelStyle: TextStyle(
                                          letterSpacing: 0.8,
                                          color: Colors.grey,
                                        ),
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(35.0),
                                            borderSide: const BorderSide(
                                                color: Colors.blue)),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 0.0),
                                        ))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, right: 50),
                                height: 30,
                                width: 340,
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: true,
                                      onChanged: (value) {},
                                      checkColor: Colors.white,
                                      activeColor: Colors.green,
                                    ),
                                    Text(
                                        "Securely save credit card and details")
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:40),
                                width: 340,
                                height: 50,
                                child: FlatButton(
                                  onPressed: () {
                                    _scaffoldState.currentState
                                        .showSnackBar(snackbar1());
                                    Future.delayed(Duration(milliseconds: 450), () {
                                      _saveCard();
                                    });
                                  },
                                  color: Colors.blue[700],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      "Add Card",
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                      top: 80,
                      left:16.5,
                      child: Container(
                        height: 250,
                        width: 380,
                        child: FlipCard(
                          key: cardKey,
                          flipOnTouch: false,
                          front: CreditCardFront(
                            name: _name,
                            creditCardNumber: _creditCardNumber,
                            expDate: _expDate,
                          ),
                          back: CreditCardBack(securityCode: _securityCode),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
