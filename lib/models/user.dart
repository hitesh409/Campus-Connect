import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final List networks;
  final String userid;
  final String userrole;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.userid,
    required this.userrole,
    required this.networks,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "Id": userid,
        "role": userrole,
        "networks": networks,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        username: snapshot['username'],
        userid: snapshot['Id'],
        userrole: snapshot['role'],
        networks: snapshot['networks']);
  }
}
