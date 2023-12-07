import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final String userid;
  final String postUrl;
  final String profImage;
  final datePublished;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.userid,
    required this.postUrl,
    required this.profImage,
    required this.likes,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postId": postId,
        "username": username,
        "Id": userid,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes,
        "datePublished": datePublished,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      username: snapshot['username'],
      userid: snapshot['Id'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
    );
  }
}
