import 'package:campus_connect_app/screens/event_screen.dart';
import 'package:campus_connect_app/screens/add_post_screen.dart';
import 'package:campus_connect_app/screens/feed_Screen.dart';
import 'package:campus_connect_app/screens/profile_screen.dart';
import 'package:campus_connect_app/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  const FeedScreen(),
  Center(
    child: Text("Chat"),
  ),
  const AddPostScreen(),
  const EventScreen(),
  const Center(
    child: Text("Notification"),
  ),
];
