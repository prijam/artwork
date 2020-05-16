//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//
//import 'CustomWidget/splashScreen.dart';
//
//class RecentVideo extends StatefulWidget {
//  final List items;
//
//  RecentVideo({this.items});
//
//  @override
//  _RecentVideoState createState() => _RecentVideoState();
//}
//
//class _RecentVideoState extends State<RecentVideo> {
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  Future getVideo() async {
//    return widget.items;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: DeviceSize.blockSizeVertical *95,
//      child: FutureBuilder(
//        future: getVideo(),
//        builder: (context, snapshot) {
//          return !snapshot.hasData
//              ? Center(
//            child: CircularProgressIndicator(
//              backgroundColor: Colors.indigo,
//            ),
//          )
//              : ListView.builder(
//              itemCount: this.widget.items.length,
//              physics: NeverScrollableScrollPhysics(),
//              itemBuilder: (BuildContext context, int index) {
//                return this.widget.items[index]["type"] == "video"
//                    ? Container(
//                  height: DeviceSize.blockSizeVertical *95,
//                  child: ListView.builder(
//                      physics: NeverScrollableScrollPhysics(),
//                      itemCount: widget.items[index]["list"].length,
//                      itemBuilder: (BuildContext context, int i) {
//                        return Column(
//                          children: <Widget>[
//                            InkWell(
//                              onTap: () {
//                                final MoreVideoModel _video =
//                                MoreVideoModel.fromJson(widget
//                                    .items[index]["list"][i]);
//                                Navigator.push(
//                                    context,
//                                    new MaterialPageRoute(
//                                        builder: (context) =>
//                                            videoDetail(
//                                              moreVideoModel: _video,
//                                            )));
//                              },
//                              child: Container(
//                                width:
//                                DeviceSize.blockSizeHorizontal *
//                                    95,
//                                height:
//                                DeviceSize.blockSizeVertical * 17,
//                                child: Stack(
//                                  children: <Widget>[
//                                    Positioned(
//                                      top: DeviceSize
//                                          .blockSizeVertical *
//                                          1.5,
//                                      child: Container(
//                                        height: DeviceSize
//                                            .blockSizeVertical *
//                                            15,
//                                        width: DeviceSize
//                                            .blockSizeHorizontal *
//                                            60,
//                                        child: Column(
//                                          crossAxisAlignment:
//                                          CrossAxisAlignment
//                                              .start,
//                                          children: <Widget>[
//                                            Text(
//                                              widget.items[index]
//                                              ["list"][i]
//                                              ["title"],
//                                              maxLines: 1,
//                                              style: TextStyle(
//                                                color: Colors.black,
//                                                fontWeight:
//                                                FontWeight.bold,
//                                              ),
//                                            ),
//                                            SizedBox(
//                                              height: DeviceSize
//                                                  .blockSizeVertical *
//                                                  1.5,
//                                            ),
//                                            Text(
//                                              widget.items[index]
//                                              ["list"][i]
//                                              ["description"],
//                                              maxLines: 3,
//                                              style: TextStyle(
//                                                  color: Colors.grey),
//                                            )
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    Positioned(
//                                      left: DeviceSize
//                                          .blockSizeHorizontal *
//                                          63,
//                                      top: DeviceSize
//                                          .blockSizeVertical *
//                                          1,
//                                      child: Card(
//                                        elevation: 5.0,
//                                        child: ClipRRect(
//                                          borderRadius:
//                                          BorderRadius.circular(
//                                              8.0),
//                                          child: Container(
//                                            height: DeviceSize
//                                                .blockSizeVertical *
//                                                10,
//                                            child: Image.network(
//                                              widget.items[index]
//                                              ["list"][i]
//                                              ["image"] ??
//                                                  "http://i3.ytimg.com/vi/${widget.items[index]["list"][i]["youtubeID"]}/hqdefault.jpg",
//                                              filterQuality:
//                                              FilterQuality.high,
//                                              fit: BoxFit.fill,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                    Positioned(
//                                      top: DeviceSize
//                                          .blockSizeVertical *
//                                          13,
//                                      child: Container(
//                                        padding: EdgeInsets.all(5.0),
//                                        decoration: BoxDecoration(
//                                          color: Colors.white,
//                                          border: Border.all(
//                                            color: Colors.black,
//                                          ),
//                                          borderRadius:
//                                          BorderRadius.circular(
//                                              2),
//                                        ),
//                                        child: Text(
//                                          widget.items[index]["list"]
//                                          [i]["category"],
//                                          style: TextStyle(
//                                              color: Colors.green,
//                                              fontWeight:
//                                              FontWeight.w800),
//                                        ),
//                                      ),
//                                    ),
//                                    Positioned(
//                                      top: DeviceSize
//                                          .blockSizeVertical *
//                                          13,
//                                      left: DeviceSize
//                                          .blockSizeHorizontal *
//                                          53,
//                                      child: Text(
//                                        DateFormat.yMEd()
//                                            .add_jms()
//                                            .format(DateTime.parse(
//                                            widget.items[index]
//                                            ["list"][i][
//                                            "published_date"])),
//                                        style: TextStyle(
//                                            letterSpacing: 1.0,
//                                            fontWeight:
//                                            FontWeight.bold,
//                                            color: Colors.grey),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Container(
//                                width:
//                                DeviceSize.blockSizeHorizontal *
//                                    95,
//                                child: Divider(
//                                  color: Colors.grey,
//                                  thickness:
//                                  DeviceSize.blockSizeVertical *
//                                      .2,
//                                )),
//                          ],
//                        );
//                      }),
//                )
//                    : Container();
//              });
//        },
//      ),
//    );
//  }
//}
