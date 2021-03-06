import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/Screens/Templates/Dashresponsable.dart';
import 'package:home_rental/Screens/Templates/ClubsList.dart';
import 'package:home_rental/Screens/HomePage.dart';
import 'package:home_rental/Screens/Templates/NotificationsPage.dart';
import 'package:home_rental/Screens/Templates/dashboard.dart';
// import 'package:home_rental/singup.dart';
// import 'package:home_rental/clubForm.dart';
import 'package:home_rental/login.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/Screens/HomePage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bar extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Bar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  var type;
  getLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tt = prefs.getString("type");
    setState(() {
      type = tt;
    });
    print(prefs.getString("type"));
  }

  @override
  void initState() {
    super.initState();
    getLoggedUser();
  }

  Logout() async {
    //clear shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xffEFEFF3), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      ClubsList(),
      // Dashresponsable(),
      // Dashboard(),
      if (type == "admin") Dashboard(),
      if (type == "manager") Dashresponsable(),
      // Login(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bookmark_fill),
        title: ("Booked"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      if (type == "admin" || type == "manager")
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.dashboard),
          title: ("Dashboard"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(CupertinoIcons.logout),
      //   title: ("Notifications"),
      //   activeColorPrimary: CupertinoColors.activeBlue,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
    ];
  }
}
