import 'package:campus_connect_app/providers/user_provider.dart';
import 'package:campus_connect_app/utils/colors.dart';
import 'package:campus_connect_app/utils/globalvariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_connect_app/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0
                ? const Icon(
                    Icons.home_rounded,
                    color: primaryColor,
                  )
                : const Icon(
                    Icons.home_rounded,
                    color: secondaryColor,
                  ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: _page == 1
                ? const Icon(
                    Icons.messenger,
                    color: primaryColor,
                  )
                : const Icon(
                    Icons.messenger_outline,
                    color: secondaryColor,
                  ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: _page == 2
                ? const Icon(
                    Icons.add_circle,
                    color: primaryColor,
                  )
                : const Icon(
                    Icons.add_circle_outline,
                    color: secondaryColor,
                  ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: _page == 3
                ? const Icon(
                    Icons.event_available,
                    color: primaryColor,
                  )
                : const Icon(
                    Icons.event_available_outlined,
                    color: secondaryColor,
                  ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: _page == 4
                ? const Icon(
                    Icons.notifications,
                    color: primaryColor,
                  )
                : const Icon(
                    Icons.notifications_none,
                    color: secondaryColor,
                  ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
