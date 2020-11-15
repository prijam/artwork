import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  final String uid;

  MyCart({this.uid});

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  var amount = 0;
  bool show = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        show = true;
      });
    });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: show == false
            ? CircularProgressIndicator()
            : PageView(
                controller: _controller,
                children: [
                  cartCollect(),
                  MyPage2Widget(),
                  MyPage3Widget(),
                ],
              ));
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0.0,
      title: Padding(
        padding: EdgeInsets.only(left: 30.0),
        child: Container(
          width: 200,
          height: 100,
          child: Row(
            children: [
              Container(
                width: 30,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
              Container(
                width: 50,
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withOpacity(0.3)),
                ),
              ),
              Container(
                width: 30,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
              Container(
                width: 50,
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withOpacity(0.3)),
                ),
              ),
              Container(
                width: 30,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartCollect() {
    return Column(
      children: [
        cart1(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            thickness: 2.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 38.0),
              child: Text(
                "Total",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text(
                "Rs." +
                        amount.toString().replaceAllMapped(
                            new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},') ??
                    "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: Text(
                "Address",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cart1() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "CART",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 500,
          child: StreamBuilder(
            stream: Firestore()
                .collection("users")
                .document(widget.uid)
                .collection("User_Data")
                .document("My_Cart")
                .collection("OrderItems")
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot.data.documents.length);
              if (snapshot.hasData) {
                List listAmount = [];
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      for (int i = 1; i < snapshot.data.documents.length; i++) {
                        listAmount.add(int.parse(snapshot
                            .data.documents[index]["price"]
                            .toString()
                            .replaceAll(",", "")));
                        amount = listAmount.fold(0, (p, c) => p + c);
                      }
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data.documents[index]
                                          ["itemImage"],
                                      height: 90,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 235,
                                height: 80,
                                child: Stack(
                                  children: [
                                    Text(
                                      snapshot.data.documents[index]["title"],
                                      style: TextStyle(
                                          fontFamily: "font1",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Positioned(
                                        right: 3.0,
                                        top: 5,
                                        child: Text(
                                          snapshot.data.documents[index]
                                              ["price"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Positioned(
                                        top: 25,
                                        child: Text(
                                          snapshot.data.documents[index]
                                              ["itemType"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    });
              } else {
                return Center(
                    child: Container(
                        height: 20, child: CircularProgressIndicator()));
              }
            },
          ),
        ),
      ],
    );
  }

// Widget cart2() {
//   return Container(
//     height: 600.5,
//     child: StreamBuilder(
//       stream: Firestore()
//           .collection("users")
//           .document(widget.uid)
//           .collection("User_Data")
//           .document("My_Cart")
//           .collection("OrderItems")
//           .snapshots(),
//       builder: (context, snapshot) {
//         print(snapshot.data.documents.length);
//         if (snapshot.hasData) {
//           return ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 snapshot.data.documents[index]["itemImage"],
//                                 height: 90,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 235,
//                           height: 80,
//                           child: Stack(
//                             children: [
//                               Text(
//                                 snapshot.data.documents[index]["title"],
//                                 style: TextStyle(
//                                     fontFamily: "font1",
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16),
//                               ),
//                               Positioned(
//                                   right: 3.0,
//                                   top: 5,
//                                   child: Text(
//                                     snapshot.data.documents[index]["price"],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                               Positioned(
//                                   top: 25,
//                                   child: Text(
//                                     snapshot.data.documents[index]
//                                         ["itemType"],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w300),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ));
//               });
//         } else {
//           return Center(
//               child:
//                   Container(height: 20, child: CircularProgressIndicator()));
//         }
//       },
//     ),
//   );
// }
}

class MyPage2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            MyBox(darkBlue, height: 50),
            MyBox(darkBlue, height: 50),
          ],
        ),
        Row(
          children: [
            MyBox(lightBlue),
            MyBox(lightBlue),
          ],
        ),
        MyBox(mediumBlue, text: 'PageView 2'),
        Row(
          children: [
            MyBox(lightBlue),
            MyBox(lightBlue),
          ],
        ),
      ],
    );
  }
}

class MyPage3Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            MyBox(darkRed),
            MyBox(darkRed),
          ],
        ),
        MyBox(mediumRed, text: 'PageView 3'),
        Row(
          children: [
            MyBox(lightRed),
            MyBox(lightRed),
            MyBox(lightRed),
          ],
        ),
      ],
    );
  }
}

const lightBlue = Color(0xff00bbff);
const mediumBlue = Color(0xff00a2fc);
const darkBlue = Color(0xff0075c9);

final lightGreen = Colors.green.shade300;
final mediumGreen = Colors.green.shade600;
final darkGreen = Colors.green.shade900;

final lightRed = Colors.red.shade300;
final mediumRed = Colors.red.shade600;
final darkRed = Colors.red.shade900;

class MyBox extends StatelessWidget {
  final Color color;
  final double height;
  final String text;

  MyBox(this.color, {this.height, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        color: color,
        height: (height == null) ? 150 : height,
        child: (text == null)
            ? null
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
