import 'package:artstore/HomePage/home.dart';
import 'package:artstore/Login/loginpage.dart';
import 'package:artstore/Login/rootScreen.dart';
import 'package:artstore/CustomWidget/splashScreen.dart';
import 'package:artstore/Login/signup.dart';
import 'package:artstore/introScreen/viewPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login/Welcome.dart';

void main() => runApp(ArtApp());

class ArtApp extends StatefulWidget {
  @override
  _ArtAppState createState() => _ArtAppState();
}

class _ArtAppState extends State<ArtApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/root': (BuildContext context) => new RootScreen(),
        '/signin': (BuildContext context) => new LoginPage(),
        '/signup': (BuildContext context) => new signup(),
        '/main': (BuildContext context) => new HomePage(),
      },
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: 400,
            width: 250,
            child: SplashScreen(
              seconds: 2,
              backgroundColor: Colors.white,
              navigateAfterSeconds: RootScreen(),
              image: new Image.asset(
                "img/aaa.png",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              loaderColor: Colors.transparent,
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
