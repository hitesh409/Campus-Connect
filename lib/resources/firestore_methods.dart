import 'package:campus_connect_app/models/event.dart';
import 'package:campus_connect_app/models/post.dart';
import 'package:campus_connect_app/resources/storege_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String userid, String profImage) async {
    String res = "some error occurred";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('posts', file, true, false);
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

// like post
  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// upload event
  Future<String> uploadEvent(String eventname, String venue, Uint8List file,
      String uid, String username, String userid, String profImage) async {
    String res = "some error occurred";
    try {
      String eventUrl = await StorageMethods()
          .uploadImageToStorage('events', file, false, true);
      String eventId = const Uuid().v1();
      Event event = Event(
        eventname: eventname,
        venue: venue,
        uid: uid,
        eventId: eventId,
        username: username,
        userid: userid,
        eventUrl: eventUrl,
        profImage: profImage,
        likes: [],
        datePublished: DateTime.now(),
      );

      _firestore.collection('events').doc(eventId).set(
            event.toJson(),
          );
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

// like event
  Future<String> likeEvent(String eventId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('events').doc(eventId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('events').doc(eventId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// delete event
  Future<String> deleteEvent(String eventId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('events').doc(eventId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// follow functionality
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        // await _firestore.collection('users').doc(uid).update({
        //   'following': FieldValue.arrayRemove([followId])
        // });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        // await _firestore.collection('users').doc(uid).update({
        //   'following': FieldValue.arrayUnion([followId])
        // });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
