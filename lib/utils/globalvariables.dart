import 'package:campus_connect_app/screens/add_post_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;
const homeScreenItems = [
  Center(
    child: Text("Home"),
  ),
  Center(
    child: Text("Chat"),
  ),
  AddPostScreen(),
  Center(
    child: Text("Event"),
  ),
  Center(
    child: Text("Notification"),
  ),
];
