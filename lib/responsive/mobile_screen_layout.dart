import 'package:campus_connect_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_connect_app/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Text("Welcome ${user.username} (${user.userid})"),
      ),
    );
  }
}



















// ----  Doesn't seem good as it costs database too much instead we should use State Management using provider package as above which is one of the convenient ways 

// String username = "";

//   @override
//   void initState() {
//     super.initState();
//     getUserName();
//   }

//   void getUserName() async {
//     //get the current user details from user collection
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();

//     setState(() {
//       username = (snapshot.data() as Map<String, dynamic>)['username'];
//     });
//   }
