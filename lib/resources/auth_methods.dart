import 'dart:typed_data';

import 'package:campus_connect_app/resources/storege_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signing up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String userId,
    required String userRole,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          userId.isNotEmpty ||
          userRole.isNotEmpty) {
        //register a user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //add user to database
        _firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'username': username,
          'email': email,
          'Id': userId,
          'role': userRole,
          'networks': [],
          'photoUrl': photoUrl,
        });

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
