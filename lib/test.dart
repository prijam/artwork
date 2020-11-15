// import 'package:flutter/material.dart';
//
// class aadsaas {
//   Widget asdh() {
//     return Stack(
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(left: 300.0),
//           child: IconButton(
//               icon: new Icon(
//                 Icons.close,
//                 color: Colors.red,
//                 size: 35.0,
//               ),
//               onPressed: () {
//                 msgcon.clear();
//                 _pri.clear();
//                 Navigator.of(context).pop(null);
//               }),
//         ),
//         Positioned(
//           top: 50,
//           left: 42,
//           child: Container(
//               height: 50,
//               width: 250,
//               child: StreamBuilder<User>(
//                 stream: Auth.getUser(snapshot.data.documents[index]["uID"]),
//                 builder: (_, snapshot) {
//                   return snapshot.hasData
//                       ? Row(
//                           children: <Widget>[
//                             CircleAvatar(
//                               radius: 17.0,
//                               backgroundImage:
//                                   NetworkImage(snapshot.data.profilePictureURL),
//                               backgroundColor: Colors.transparent,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 6.0, left: 15),
//                               child: Text(
//                                 snapshot.data.firstName,
//                                 style: TextStyle(
//                                     color: Colors.blueAccent[400],
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             )
//                           ],
//                         )
//                       : Container();
//                 },
//               )),
//         ),
//         Positioned(
//           top: 100,
//           left: 40,
//           child: Container(
//             height: 200,
//             width: 300,
//             child: Image.network(
//               snapshot.data.documents[index]["itemImage"],
//               fit: BoxFit.cover,
//               filterQuality: FilterQuality.high,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 295,
//           left: 40,
//           child: Container(
//             margin: EdgeInsets.only(right: 40, top: 15),
//             height: 20,
//             width: 254,
//             child: Text(
//               snapshot.data.documents[index]["title"],
//               style: TextStyle(fontFamily: "font2"),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 328,
//           left: 40,
//           child: Container(
//             margin: EdgeInsets.only(right: 95),
//             height: 70,
//             width: 250,
//             child: Text(
//               snapshot.data.documents[index]["description"],
//               style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black.withOpacity(0.5)),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 173,
//           right: 1,
//           child: Container(
//             height: 20,
//             width: 80,
//             child: Text(
//               snapshot.data.documents[index]["price"]
//                   .replaceAllMapped(reg, mathFunc),
//               style: TextStyle(fontFamily: "font2", color: Colors.red),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 140,
//           right: 8,
//           child: Container(
//             height: 18,
//             width: 80,
//             child: Text("Your price"),
//           ),
//         ),
//         Positioned(bottom: 125, right: -14, child: pri()),
//         Positioned(bottom: 30, left: 40, child: messageBox()),
//         Positioned(
//           bottom: 10,
//           right: 10,
//           child: Container(
//             width: 350,
//             height: 40,
//             child: RaisedButton(
//               color: Colors.deepOrange,
//               onPressed: () {
//                 _sendMsg(context, snapshot, index);
//               },
//               child: Text(
//                 "Send Message",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
