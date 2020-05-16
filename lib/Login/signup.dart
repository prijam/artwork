import 'package:artstore/CustomWidget/alret.dart';

import 'package:artstore/Login/validator.dart';
import 'package:artstore/firebaseHandler/auth.dart';
import 'package:artstore/Login/LoginProgress.dart';

import 'package:artstore/firebaseHandler/userModel.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  bool showProgressloading = false;
  bool sp = true;
  VoidCallback onBackPress;
  final TextEditingController _fullname = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    onBackPress = () {
      Navigator.of(context).pop();
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          key: _scaffoldState,
          backgroundColor: Colors.white,
          body: LP(
            inAsyncCall: showProgressloading,
            child: SingleChildScrollView(
              child: Container(
                height: 800,
                width: 500,
                color: Colors.white,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      introTitle(),
                      SizedBox(
                        height: 20.0,
                      ),
                      UserName(),
                      Email(),
                      Phone(),
                      Password(),
                      ConfirmPassword(),
                      SizedBox(
                        height: 20,
                      ),
                      ShowPassword(),
                      SizedBox(
                        height: 20,
                      ),
                      CreatBtn(),
                      SizedBox(
                        height: 40,
                      ),
                      Already(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget introTitle() {
    return Column(
      children: <Widget>[
        Text(
          "Let's Get Started!",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.black,
              fontSize: 22.0),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            "Create an account to Art Store to get all features",
            style: TextStyle(color: Colors.grey[600]),
          ),
        )
      ],
    );
  }

  Widget UserName() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextFormField(
            controller: _fullname,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                ))));
  }

  Widget Email() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextFormField(
            controller: _email,
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

  Widget Phone() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextFormField(
            controller: _number,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelText: "Phone",
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.mobile_screen_share,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                ))));
  }

  Widget Password() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextFormField(
            controller: _password,
            obscureText: sp,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                ))));
  }

  Widget ConfirmPassword() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20.0),
        child: new TextField(
            obscureText: sp,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
                labelText: "Confrim Password",
                labelStyle: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                ))));
  }

  Widget CreatBtn() {
    return ButtonTheme(
      minWidth: 150.0,
      height: 50,
      child: RaisedButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onPressed: () {
          setState(() {
            showProgressloading = true;
          });
          _signUp(
              fullname: _fullname.text,
              email: _email.text,
              number: _number.text,
              password: _password.text);
        },
        color: Colors.green,
        textColor: Colors.white,
        child: Text("CREATE"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white70)),
      ),
    );
  }

  Widget ShowPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        children: <Widget>[
          Checkbox(
            checkColor: Colors.green[900],
            activeColor: Colors.white,
            value: !sp,
            onChanged: (bool value) {
              setState(() {
                sp = !value;
              });
            },
          ),
          Text("Show Password")
        ],
      ),
    );
  }

  Widget Already(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Already Have an account?"),
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/signin");
          },
          child: Text(
            "Login here",
            style:
                TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  void _signUp(
      {String fullname,
      String number,
      String email,
      String password,
      BuildContext context}) async {
    if (Validator.validateName(fullname) &&
        Validator.validateEmail(email) &&
        Validator.validateNumber(number) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await Auth.signUp(email, password).then((uID) {
          Auth.addUser(new User(
              userID: uID,
              email: email,
              number: number,
              firstName: fullname,
              password: password,
              profilePictureURL:
                  'https://firebasestorage.googleapis.com/v0/b/artwork-6cc55.appspot.com/o/12655456.jpg?alt=media&token=79de6aac-03a8-4288-ba85-07ffd510120e'));
        }).then((uID) {
          setState(() {
            showProgressloading = false;
            _scaffoldState.currentState.showSnackBar(accountCreated());
          });
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              onBackPress();
            });
          });
        });
      } catch (e) {
        print("Error in sign up: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Signup failed",
          content: exception,
        );
      }
    }
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }

  Widget accountCreated() {
    return SnackBar(
      backgroundColor: Colors.green,
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
            child: Text("Account created"),
          )
        ],
      ),
    );
  }
}
