import 'package:flutter/material.dart';

class CreditCardBack extends StatelessWidget {
  final String securityCode;

  CreditCardBack({this.securityCode});

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
        child:Image.asset("img/master.png",height:30,)),
        Positioned(
            bottom: 10,
            right: 20,
            child: Text(securityCode,
                style: TextStyle(fontSize: 22, color: Colors.white)))
      ]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: _buildStack(context),
    );
  }
}
