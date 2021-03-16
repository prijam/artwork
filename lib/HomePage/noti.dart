import 'dart:convert';
import 'package:artstore/CustomWidget/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List _items = [];
  var height = DeviceSize.blockSizeVertical;
  var width = DeviceSize.blockSizeHorizontal;

  static Future<String> getPreferences(String key) async {
    return ((await SharedPreferences?.getInstance())?.getString(key)) ?? "";
  }

  static Future<Null> setPreferences(String key, String value) async {
    (await SharedPreferences?.getInstance())?.setString(key, value);
  }

  @override
  void initState() {
    super.initState();
    try {
      getPreferences("notifications").then((data) {
        setState(() {
          if (data.isNotEmpty && (data is String)) {
            _items = json.decode(data);
          } else {
            _items = [];
          }
//        print(_items);
        });
      });
    } catch (e) {
      setState(() {
        _items = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _items.length == 0
          ? Center(
              child: Text(
                "No Notifications",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return itemView(index);
              },
            ),
    );
  }

  Widget itemView1(int index) {
    Map listItem = _items[index];
    String title =
        listItem['alert_title'] ?? listItem["data"]['alert_title'] ?? "";
    String body =
        listItem['alert_body'] ?? listItem["data"]['alert_body'] ?? "";
    String url = listItem['url'] ?? listItem["data"]['url'] ?? "";
    String received_at =
        listItem['received_at'] ?? listItem["data"]['received_at'] ?? "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: new ListTile(
          title: new Text(title),
//          subtitle: new Text(listItem["data"]["body"]+"\n"+ Utilities.getHumanReadableTime(listItem['recieved_at'].floor()??0) + " ago"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(body),
            ],
          ),
          trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _delNotification(index)),
//           onTap: () {
//            if(!Utilities.isEmpty(listItem['data']["urls"]))
//              Utilities.openUrl(listItem['data']["urls"]);
//            },
        ),
      ),
    );
  }

  Widget itemView(int index) {
    Map listItem = _items[index];
    String title =
        listItem['alert_title'] ?? listItem["data"]['alert_title'] ?? "";
    String body =
        listItem['alert_body'] ?? listItem["data"]['alert_body'] ?? "";
    String url = listItem['url'] ?? listItem["data"]['url'] ?? "";
    String received_at =
        listItem['received_at'] ?? listItem["data"]['received_at'] ?? "";
    var dateTime = DateTime.parse(received_at);
    var formatTime = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
        child: Container(
          height: height * 13,
          decoration: BoxDecoration(),
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 5,
                ),
                Container(
                  width: width * 13,
                  height: height * 7,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.blueGrey,
                      size: height * 3,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        body,
                        style: TextStyle(fontSize: height * 1.8),
                      ),
                      SizedBox(
                        height: height * .5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color.fromRGBO(202, 202, 202, 1.0),
                            size: 16,
                          ),
                          SizedBox(
                            width: width * 1,
                          ),
                          Text(
                            formatTime,
                            style: TextStyle(
                                color: Color.fromRGBO(202, 202, 202, 1.0),
                                fontWeight: FontWeight.w600,
                                fontSize: height * 1.4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _delNotification(index)),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left:20.0),
                //       child: Text(
                //         transaction.beneficiaryName.toUpperCase() ?? "",
                //         style: TextStyle(
                //             color: Utilities.goldenTheme,
                //             fontSize: height * 2,
                //             fontWeight: FontWeight.w600),
                //       ),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //
                //       children: [
                //         Icon(Icons.calendar_today,color: Colors.grey,size: 15.0,),
                //         Text(
                //           transaction.transactionDate,
                //           style: TextStyle(
                //               fontWeight: FontWeight.w600,
                //               fontSize: height * 1.8),
                //         ),
                //       ],
                //     )
                //
                //   ],
                // )
              ],
            ),
          ),
        ));
  }

  Widget itemView3(int index) {
    Map listItem = _items[index];
    String title =
        listItem['alert_title'] ?? listItem["data"]['alert_title'] ?? "";
    String body =
        listItem['alert_body'] ?? listItem["data"]['alert_body'] ?? "";
    String url = listItem['url'] ?? listItem["data"]['url'] ?? "";
    String received_at =
        listItem['received_at'] ?? listItem["data"]['received_at'] ?? "";
    var dateTime = DateTime.parse(received_at);
    var formatTime = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListTile(
            leading: Container(
              width: width * 13,
              height: height * 6,
              decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.blueGrey,
                  size: height * 3,
                ),
              ),
            ),
            title: Text(body),
            trailing: Column(
              children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _delNotification(index)),
                Text(formatTime)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _delNotification(int index) {
    setState(() {
      _items.removeAt(index);
    });
    setPreferences("notifications", json.encode(_items));
  }
}
