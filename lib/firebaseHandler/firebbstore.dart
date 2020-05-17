import 'package:cloud_firestore/cloud_firestore.dart';

class firestore {
  Future getArt() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("art").getDocuments();
    return qn.documents;
  }

  Future getsimiarWork() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("similarwork").getDocuments();
    return qn.documents;
  }
  Future user() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("similarwork").getDocuments();
    return qn.documents;
  }

  Future getbestseliing() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("bestsellings").getDocuments();
    return qn.documents;
  }

  Future getCraft() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("craft").getDocuments();
    return qn.documents;
  }

  Future getillu() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("illu").getDocuments();
    return qn.documents;
  }

  Future getPaint() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("paint").getDocuments();
    return qn.documents;
  }

  Future seemore1() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("seemore1").getDocuments();
    return qn.documents;
  }

  Future getSeemore2() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("seemore2").getDocuments();
    return qn.documents;
  }
  Future explore() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("explore").getDocuments();
    return qn.documents;
  }
}
