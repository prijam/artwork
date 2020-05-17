import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> with TickerProviderStateMixin {
  TabController _tabController;
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

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
            Container(
              color: Colors.red,
              height:84,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[

                    ],
                  )
                ],
              ),
            )
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
        children: <Widget>[
          explore(),
          Container(),
          Container(),
          Container(),
          Container()
        ],
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
                          placeholder: "img/home.gif",
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
