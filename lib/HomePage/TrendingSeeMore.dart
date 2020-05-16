
import 'package:flutter/material.dart';

import '../firebaseHandler/firebbstore.dart';

class TrendingSeeMore extends StatefulWidget {
  @override
  _TrendingSeeMoreState createState() => _TrendingSeeMoreState();
}

class _TrendingSeeMoreState extends State<TrendingSeeMore> {
  firestore fire = firestore();

  List<Color> colors = [
    Colors.teal[400],
    Colors.grey[400],
    Colors.red[400],
    Colors.deepPurple[400],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData.fallback(),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: 950,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                best(),
                SizedBox(
                  height: 25,
                ),
                detailPage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget best() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Container(
        height: 40,
        width: 380,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Trending",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                  letterSpacing: 0.7,
                  color: Colors.black.withOpacity(0.7)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.0),
                  borderRadius:
                      new BorderRadius.all(Radius.elliptical(140, 150)),
                ),
                width: 85,
                height: 35,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Sort By")),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                        size: 16,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget detailPage() {
    return Container(
      height: 870,
      width: 500,
      child: FutureBuilder(
        future: fire.getSeemore2(),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Container(
                      height: 220,
                      width: 500,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 65,
                            top: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colors[index],
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              height: 190,
                              width: 330,
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 5,
                            child: Container(
                              height: 170,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "img/load.gif",
                                    image: snapshot.data[index].data["img"],
                                    fadeInCurve: Curves.easeIn,
                                    fit: BoxFit.cover,
                                  )),
                              width: 125,
                            ),
                          ),
                          Positioned(
                            left: 160,
                            top: 20,
                            child: Container(
                              height: 170,
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data[index].data["title"] ?? "",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'font1',
                                        color: Colors.white.withOpacity(1),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[index].data["artist"] ?? "",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        letterSpacing: 0.5,
                                        fontFamily: 'font2',
                                        fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data[index].data["rating"] ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          snapshot.data[index].data["total"] ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 300,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                            top: 8,
                                            left: 5,
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.white,
                                              size: 18.0,
                                            )),
                                        Positioned(
                                            left: 35,
                                            top: 8,
                                            child: Text(
                                              snapshot.data[index]
                                                      .data["sell"] ??
                                                  "",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            )),
                                        Positioned(
                                            left: 58,
                                            top:9,
                                            child: Text(
                                              "Purchase",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            )),
                                        Positioned(
                                          left: 135,
                                          child: Container(
                                            height: 35,
                                            child: VerticalDivider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 155,
                                          child: Text(
                                            "Price",
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Positioned(
                                          left: 155,
                                          top: 20,
                                          child: Text(
                                            "Rs",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 178,
                                          top: 19.5,
                                          child: Text(
                                            snapshot.data[index]
                                                    .data["price"] ??
                                                "",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.5,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                );
        },
      ),
    );
  }
}
