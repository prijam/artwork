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
  var totalItem = 0;
  bool show = false;
  var currentPage = "";

  @override
  void initState() {
    _controller = PageController();
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
        appBar: appBar(),
        body: PageView(
          controller: _controller,
          onPageChanged: _onPageViewChange,
          children: [
            cartCollect(),
            Center(child: Text("Address Page")),
            Center(child: Text("Checkout Page")),
          ],
        ));
  }

  _onPageViewChange(int page) {
    currentPage = page.toString();

    int previousPage = page;
    if (page != 0)
      previousPage--;
    else
      previousPage = 2;
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
                    color: currentPage == 1.toString() ||
                            currentPage == 2.toString()
                        ? Colors.green
                        : Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
              Container(
                width: 50,
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: Colors.transparent,
                  valueColor:
                      currentPage == 1.toString() || currentPage == 2.toString()
                          ? AlwaysStoppedAnimation<Color>(Colors.green)
                          : AlwaysStoppedAnimation<Color>(
                              Colors.grey.withOpacity(0.3)),
                ),
              ),
              Container(
                width: 30,
                height: 50,
                decoration: BoxDecoration(
                    color: currentPage == 1.toString() ||
                            currentPage == 2.toString()
                        ? Colors.green
                        : Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
              Container(
                width: 50,
                child: LinearProgressIndicator(
                  value: 100,
                  backgroundColor: Colors.transparent,
                  valueColor: currentPage == 2.toString()
                      ? AlwaysStoppedAnimation<Color>(Colors.green)
                      : AlwaysStoppedAnimation<Color>(
                          Colors.grey.withOpacity(0.3)),
                ),
              ),
              Container(
                width: 30,
                height: 50,
                decoration: BoxDecoration(
                    color: currentPage == 2.toString()
                        ? Colors.green
                        : Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartCollect() {
    List finalAmount = [amount, 500, 15];
    var sum = finalAmount.reduce((a, b) => a + b);
    return ListView(
      children: [
        cart1(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            thickness: 2.0,
          ),
        ),
        Card(
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 175,
              child: ListView(
                children: [
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    dense: true,
                    contentPadding: EdgeInsets.all(0.0),
                    leading: Text(
                      "Total Item",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                    trailing: Text(
                      totalItem.toString(),
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.all(0.0),
                    leading: Text(
                      "Item total",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                    trailing: Text(
                      "Rs." +
                              amount.toString().replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},') ??
                          "",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.all(0.0),
                    leading: Text(
                      "Delivery charge",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                    trailing: Text(
                      "Rs.500",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.all(0.0),
                    leading: Text(
                      "Tax",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                    trailing: Text(
                      "Rs.15",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.all(0.0),
                    leading: Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19.0),
                    ),
                    trailing: Text(
                      "Rs." +
                              sum.toString().replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},') ??
                          "",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            if (_controller.hasClients) {
              _controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 38.0, right: 38.0),
            child: Container(
              width: 100,
              height: 50,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.double_arrow,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
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
          height: 370,
          child: StreamBuilder(
            stream: Firestore()
                .collection("users")
                .document(widget.uid)
                .collection("User_Data")
                .document("My_Cart")
                .collection("OrderItems")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List listAmount = [];
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      for (int i = 1;
                          i < snapshot.data.documents.length - 1;
                          i++) {
                        listAmount.add(int.parse(snapshot
                            .data.documents[index]["price"]
                            .toString()
                            .replaceAll(",", "")));
                        amount = listAmount.fold(0, (p, c) => p + c);
                        totalItem = snapshot.data.documents.length;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          elevation: 0.0,
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
                                      width: 140,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 245,
                                height: 90,
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
                                    Positioned(
                                      right: 0.0,
                                      bottom: 0.0,
                                      child: IconButton(
                                        onPressed: () async {
                                          listAmount.removeAt(index - 1);
                                          amount = listAmount.fold(
                                              0, (p, c) => p + c);
                                          totalItem = listAmount.length;
                                          delete(index);
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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

  void delete(int index) async {
    CollectionReference col = Firestore.instance
        .collection("users")
        .document(widget.uid)
        .collection("User_Data")
        .document("My_Cart")
        .collection("OrderItems");
    QuerySnapshot q = await col.getDocuments();
    q.documents[index].reference.delete();
  }
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
