import "package:campus_connect_app/screens/profile_screen.dart";
import "package:campus_connect_app/screens/search_screen.dart";
import "package:campus_connect_app/utils/colors.dart";
import "package:campus_connect_app/utils/globalvariables.dart";
import "package:campus_connect_app/widgets/post_card.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/MyLogo_Top.svg',
                height: 40,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                              uid: FirebaseAuth.instance.currentUser!.uid)),
                    );
                  },
                  icon: const Icon(
                    Icons.person_2_outlined,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 35,
                  ),
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
