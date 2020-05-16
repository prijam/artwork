import 'package:flutter/material.dart';

import 'loginpage.dart';

class forgotpassword extends StatefulWidget {
  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
        height:760,

        child: Stack(
            children: <Widget>[
              Container(
                height: 400,
                width: 500,
                child: Image.asset(
                  'img/forgot.gif',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 350,
                left:32,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  height: 400,
                  width: 350,
                  child: Column(
                    children: <Widget>[
                      title(),
                      SizedBox(
                        height: 20,
                      ),
                      sub(),
                      SizedBox(
                        height: 20,
                      ),
                      Email(),
                      SizedBox(
                        height:40,
                      ),
                      sendBtn(),
                      SizedBox(
                        height:20,
                      ),
                      cancelBtn(),
                    ],
                  ),
                ),
              )
            ],
        ),
      ),
          )),
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, right: 80),
      child: Text(
        "Forgot your password?",
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.0, letterSpacing: 0.5),
      ),
    );
  }

  Widget sub() {
    return Container(
      height: 40,
      width: 300,
      child: Text(
        "Enter Your Email address and we will send you a code to reset your password",
        style: TextStyle(
            color: Colors.grey,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget Email() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                ))));
  }

  Widget sendBtn() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      width: 300,
      height:50,

      child: Padding(
        padding:  EdgeInsets.only(top:12.0),
        child: Text("Send",textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          fontSize:20.0,
          color: Colors.white
        ),),
      ),
    );
  }
  Widget cancelBtn() {
    return InkWell(
      onTap: (){
        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.red.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        width: 300,
        height:50,
        child: Padding(
          padding:  EdgeInsets.only(top:12.0),
          child: Text("Cancel",textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              fontSize:20.0,
              color: Colors.black.withOpacity(0.5)
          ),),
        ),
      ),
    );
  }
}
