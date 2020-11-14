import 'package:artstore/CustomWidget/alret.dart';
import 'package:artstore/Login/ForgotPass.dart';
import 'package:artstore/Login/signup.dart';
import 'package:artstore/Login/validator.dart';
import 'package:artstore/firebaseHandler/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginProgress.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool sp = true;
  bool showProgressloading = false;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      body: SafeArea(
        child: LP(
          inAsyncCall: showProgressloading,
          child: SingleChildScrollView(
            child: Container(
              height: 800,
              child: Form(
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 190, child: Image.asset('img/Capture.JPG')),
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Login in to your existant account of Art Store",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    showEmailInput(),
                    SizedBox(
                      height: 12,
                    ),
                    showPasswordInput(),
                    SizedBox(
                      height: 15,
                    ),
                    passSection(),
                    SizedBox(
                      height: 15,
                    ),
                    LoginButton(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Or connect using",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        fbbtn(),
                        SizedBox(
                          width: 30,
                        ),
                        gbtn()
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Sing Up",
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Container(
      height: 100,
      width: 365,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.6),
                letterSpacing: 0.5),
          ),
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
              controller: _email,
              textInputAction: TextInputAction.next,
//              controller: _email..text = 'prijam36@gmail.com',
              style: TextStyle(color: Colors.black),

              decoration: new InputDecoration(
                  hintText: "Email",
                  filled: true,
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
                    borderSide:
                        const BorderSide(color: Colors.green, width: 0.0),
                  )))
        ],
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      height: 100,
      width: 365,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Password",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: Colors.black.withOpacity(0.6),
                fontSize: 16.0),
          ),
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
              obscureText: sp,
              controller: _password,
              style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                  hintText: "Password",
                  filled: true,
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
                    borderSide:
                        const BorderSide(color: Colors.green, width: 0.0),
                  )))
        ],
      ),
    );
  }

  Widget passSection() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ShowPassword(),
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => forgotpassword()));
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
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

  Widget LoginButton() {
    return ButtonTheme(
      minWidth: 150.0,
      height: 50,
      child: RaisedButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onPressed: () {
          if (!mounted) return;
          _emailLogin(
              email: _email.text, password: _password.text, context: context);
          setState(() {
            showProgressloading = true;
          });
          new Future.delayed(const Duration(seconds: 5), () {
            setState(() => showProgressloading = false);
          });
        },
        color: Colors.green,
        textColor: Colors.white,
        child: Text("LOG IN"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.white70)),
      ),
    );
  }

  Widget gbtn() {
    return InkWell(
      onTap: () {
        _scaffoldkey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: <Widget>[
              Icon(Icons.playlist_add),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Text("Feature to be added"),
              )
            ],
          ),
        ));
      },
      child: Container(
        height: 35,
        width: 110,
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: <Widget>[
            Container(height: 30, child: Image.asset("img/gg.png")),
            Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                "Google",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fbbtn() {
    return InkWell(
      onTap: () {
        _scaffoldkey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.indigo,
          duration: Duration(seconds: 1),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: <Widget>[
              Icon(Icons.playlist_add),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Text("Feature to be added"),
              )
            ],
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo[600],
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 35,
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(height: 25.0, child: Image.asset("img/ff.png")),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                "Facebook",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _emailLogin({
    String email,
    String password,
    BuildContext context,
  }) async {
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await Auth.signIn(email, password)
            .then((uid) => Navigator.of(context).pop());
      } catch (e) {
        setState(() {
          showProgressloading = false;
        });
        print("Error in email sign in: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Login failed",
          content: exception,
        );
      }
    }
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
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
}
