import 'dart:async';
import 'dart:io';
import 'package:artstore/CustomWidget/splashScreen.dart';
import 'package:artstore/Login/Welcome.dart';
import 'package:artstore/Login/loginpage.dart';
import 'package:artstore/Login/rootScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class introSlider extends StatefulWidget {
  @override
  _introSliderState createState() => _introSliderState();
}

class _introSliderState extends State<introSlider> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildPageIndicator(bool isCurrentPage) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        height: isCurrentPage ? 10.0 : 6.0,
        width: isCurrentPage ? 10.0 : 6.0,
        decoration: BoxDecoration(
          color: isCurrentPage ? Colors.red : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }


    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: DeviceSize.blockSizeVertical * 20,
                ),
                Container(
                  height: DeviceSize.blockSizeVertical * 50,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        slideIndex = index;
                      });
                    },
                    children: <Widget>[
                      SlideTile(
                        imagePath: mySLides[0].getImageAssetPath(),
                        title: mySLides[0].getTitle(),
                        desc: mySLides[0].getDesc(),
                      ),
                      SlideTile(
                        imagePath: mySLides[1].getImageAssetPath(),
                        title: mySLides[1].getTitle(),
                        desc: mySLides[1].getDesc(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SlideTile(
                          imagePath: mySLides[2].getImageAssetPath(),
                          title: mySLides[2].getTitle(),
                          desc: mySLides[2].getDesc(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: DeviceSize.blockSizeHorizontal * 50,
                  height: DeviceSize.blockSizeVertical * 5,
                  margin:
                      EdgeInsets.only(top: DeviceSize.blockSizeVertical * 5),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.green)),
                    color: Color.fromRGBO(38, 193, 101, 1.0),
                    onPressed: () {
                      slideIndex <= 1
                          ? controller.animateToPage(slideIndex + 1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear)
                          : Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (context) => RootScreen()));
                    },
                    splashColor: Colors.blue[50],
                    child: Text(
                      slideIndex <= 1 ? "Next" : "Continue",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20), child: Image.asset(imagePath)),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, fontFamily: 'font'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'font2',
                  color: Colors.grey))
        ],
      ),
    );
  }
}
