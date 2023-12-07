import 'dart:typed_data';

import 'package:campus_connect_app/models/post.dart';
import 'package:campus_connect_app/resources/storege_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String userid, String profImage) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        postId: postId,
        username: username,
        userid: userid,
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
        datePublished: DateTime.now(),
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
