import 'package:campus_connect_app/providers/user_provider.dart';
import 'package:campus_connect_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {required this.webScreenLayout,
      required this.mobileScreenLayout,
      super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //webscreen
        return widget.webScreenLayout;
      }
      //mobilescreen
      return widget.mobileScreenLayout;
    });
  }
}
