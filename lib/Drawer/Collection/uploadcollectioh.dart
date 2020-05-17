import 'package:artstore/firebaseHandler/firebbstore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> with TickerProviderStateMixin {
  TabController _tabController;
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  firestore fire = firestore();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        height: 950,
        width: 450,
        child: Column(
          children: <Widget>[
//            SizedBox(
//              height: 10.0,
//            ),
//            tabbar(),
//            tabview(),
            SingleChildScrollView(
              child: Container(
                height: 720,
                width: 450,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0))),
                child: Column(
                  children: <Widget>[
                    tabbar(),
                    tabview(),
                  ],
                ),
              ),
            ),
//            SingleChildScrollView(
//              scrollDirection: Axis.horizontal,
//              child: Container(
//                height:84,
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      margin: EdgeInsets.only(left: 10,top: 20),
//                      height: 50,
//                      width: 70,
//                      child: Text("Items Overview",
//                      style: TextStyle(
//                        color: Colors.grey.withOpacity(0.7),
//                        fontFamily: 'font2'
//                      ),),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10,top:27),
//                      height: 60,
//                      width: 80,
//                      child: Column(
//                        children: <Widget>[
//                          Text("Total Items",
//                            style: TextStyle(
//                                color: Colors.grey.withOpacity(0.7),
//                                fontFamily: 'font2'
//                            ),),
//                          Container(
//                              height: 40,
//                              width: 50,
//                            child: FutureBuilder(
//                              future: fire.explore(),
//                              builder: (_,snapshot){
//                                return snapshot.hasData?Container(
//                                  height: 40,
//                                    width: 50,
//                                    child: Container(
//                                      margin: EdgeInsets.only(left:18,top: 3),
//                                        child: Text(snapshot.data.length.toString(),style: TextStyle(
//                                          color: Colors.white,
//                                            fontWeight: FontWeight.bold,
//                                            fontFamily: 'font1',
//                                          fontSize: 16.0
//                                        ),))):CircularProgressIndicator();
//                              },
//                            )
//                          )
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10,top:28),
//                      height: 60,
//                      width: 80,
//                      child: Column(
//                        children: <Widget>[
//                          Text("Art",
//                            style: TextStyle(
//                                color: Colors.grey.withOpacity(0.7),
//                                fontFamily: 'font2'
//                            ),),
//                          Container(
//                              height: 40,
//                              width: 50,
//                              child: FutureBuilder(
//                                future: fire.art(),
//                                builder: (_,snapshot){
//                                  return snapshot.hasData?Container(
//                                      height: 40,
//                                      width: 50,
//                                      child: Container(
//                                          margin: EdgeInsets.only(left:18,top: 2),
//                                          child: Text(snapshot.data.length.toString(),style: TextStyle(
//                                              color: Colors.white,
//                                            fontWeight: FontWeight.bold,
//                                              fontFamily: 'font1',
//                                              fontSize: 16.0
//                                          ),))):CircularProgressIndicator();
//                                },
//                              )
//                          )
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10,top:28),
//                      height: 60,
//                      width: 80,
//                      child: Column(
//                        children: <Widget>[
//                          Text("Paint",
//                            style: TextStyle(
//                                color: Colors.grey.withOpacity(0.7),
//                                fontFamily: 'font2'
//                            ),),
//                          Container(
//                              height: 40,
//                              width: 50,
//                              child: FutureBuilder(
//                                future: fire.paint(),
//                                builder: (_,snapshot){
//                                  return snapshot.hasData?Container(
//                                      height: 40,
//                                      width: 50,
//                                      child: Container(
//                                          margin: EdgeInsets.only(left:18,top: 2),
//                                          child: Text(snapshot.data.length.toString(),style: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontFamily: 'font1',
//                                              fontSize: 16.0
//                                          ),))):CircularProgressIndicator();
//                                },
//                              )
//                          )
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10,top:28),
//                      height: 60,
//                      width: 80,
//                      child: Column(
//                        children: <Widget>[
//                          Text("Craft",
//                            style: TextStyle(
//                                color: Colors.grey.withOpacity(0.7),
//                                fontFamily: 'font2'
//                            ),),
//                          Container(
//                              height: 40,
//                              width: 50,
//                              child: FutureBuilder(
//                                future: fire.craft(),
//                                builder: (_,snapshot){
//                                  return snapshot.hasData?Container(
//                                      height: 40,
//                                      width: 50,
//                                      child: Container(
//                                          margin: EdgeInsets.only(left:18,top: 2),
//                                          child: Text(snapshot.data.length.toString(),style: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontFamily: 'font1',
//                                              fontSize: 16.0
//                                          ),))):CircularProgressIndicator();
//                                },
//                              )
//                          )
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10,top:28),
//                      height: 60,
//                      width: 80,
//                      child: Column(
//                        children: <Widget>[
//                          Text("Illustration",
//                            style: TextStyle(
//                                color: Colors.grey.withOpacity(0.7),
//                                fontFamily: 'font2'
//                            ),),
//                          Container(
//                              height: 40,
//                              width: 50,
//                              child: FutureBuilder(
//                                future: fire.illu(),
//                                builder: (_,snapshot){
//                                  return snapshot.hasData?Container(
//                                      height: 40,
//                                      width: 50,
//                                      child: Container(
//                                          margin: EdgeInsets.only(left:18,top: 2),
//                                          child: Text(snapshot.data.length.toString(),style: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.bold,
//                                              fontFamily: 'font1',
//                                              fontSize: 16.0
//                                          ),))):CircularProgressIndicator();
//                                },
//                              )
//                          )
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Widget tabbar() {
    return DefaultTabController(
      length: 5,
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.black,
        indicatorColor: Colors.white,
        controller: _tabController,
        unselectedLabelColor: Colors.grey.withOpacity(0.4),
        tabs: <Widget>[
          Tab(
            child: Text('Explore',
                style: TextStyle(
                  fontSize: 35.0,
                )),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Art',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Paint',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Craft',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Illustration',
                  style: TextStyle(
                    fontSize: 35.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabview() {
    return Container(
      height: 650.0,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[explore(), art(), paint(), craft(), illu()],
      ),
    );
  }

  Widget explore() {
    return StreamBuilder(
      stream: Firestore.instance.collection("explore").snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    String price = snapshot.data.documents[index]["price"];
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "img/img.gif",
                          image: snapshot.data.documents[index]["itemImage"],
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.0 : 1.60);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget art() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Art")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        String price = snapshot.data.documents[index]["price"];
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: "img/img.gif",
                              image: snapshot.data.documents[index]
                                  ["itemImage"],
                              fit: BoxFit.cover,
                              fadeInCurve: Curves.easeIn,
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(
                            1, index.isEven ? 1.0 : 1.60);
                      },
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget paint() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Paint")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "img/img.gif",
                          image: snapshot.data.documents[index]["itemImage"],
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.0 : 1.60);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget craft() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Craft")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    String price = snapshot.data.documents[index]["price"];
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "img/img.gif",
                          image: snapshot.data.documents[index]["itemImage"],
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.0 : 1.60);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }

  Widget illu() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("userupload")
          .document("Illustration")
          .collection("Uploads")
          .snapshots(),
      builder: (_, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    String price = snapshot.data.documents[index]["price"];
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "img/img.gif",
                          image: snapshot.data.documents[index]["itemImage"],
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.0 : 1.60);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
      },
    );
  }
}
