import 'package:flutter/material.dart';

class CreditCardFront extends StatelessWidget {
  final String creditCardNumber;
  final String name;
  final String expDate;

  CreditCardFront({this.creditCardNumber, this.name, this.expDate});

  Widget _buildStack(context) => Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.circular(25)),
        ),
        Positioned(
            top: 20,
            left: 20,
            child: Image.asset("img/master.png",filterQuality: FilterQuality.high,height:30,)),
        Positioned(
            top: 20,
           right: 20,
            child: Text(expDate,
                style: TextStyle(fontSize: 20, color: Colors.white70))),
        Positioned(
            left: 20,
            top: 80,
            child: Container(
              height: 100,
              width: 340,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 5,
                    child: Text(creditCardNumber,
                        style: TextStyle(fontSize: 24, color: Colors.white70)),
                  ),
                  Positioned(
                      top: 70,
                      left: 10,
                      child: Text(name,
                          style:
                              TextStyle(fontSize: 20, color: Colors.white70))),
                  Positioned(
                    right: 20,
                    bottom: 10,
                    child: Text(
                      "Credit card",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: _buildStack(context),
    );
  }
}
