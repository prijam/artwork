import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userID;
  final String firstName;
  final String email;
  final String number;
  final String profilePictureURL;
  final String password;

  User({
    this.userID,
    this.firstName,
    this.email,
    this.number,
    this.profilePictureURL,
    this.password
  });

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'firstName': firstName,
      'email': email == null ? '' : email,
      'profilePictureURL': profilePictureURL,
      'contactNumber':number,
      'password':password
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      userID: doc['userID'],
      firstName: doc['firstName'],
      email: doc['email'],
      number: doc['contactNumber'],
      profilePictureURL: doc['profilePictureURL'],
      password: doc['password']
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}