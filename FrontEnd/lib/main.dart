import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/singup_manager.dart';
import './Screens/Templates/Dashresponsable.dart';
import './Screens/Templates/ClubsList.dart';
import './Screens/HomePage.dart';
import './Screens/Templates/NotificationsPage.dart';
import './Screens/Templates/dashboard.dart';
import './responsable/event/dashevent.dart';
import './responsable/team/addTeam.dart';
import './responsable/team/dashteam.dart';
import './signup.dart';
import './clubForm.dart';
import './login.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClubiX',
      // initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/signupManager': (context) => SignupManager(),
        '/home': (context) => HomePage(),
        '/clubForm': (context) => clubForm(),
        '/clubs_list': (context) => ClubsList(),
        '/dash_admin': (context) => Dashboard(),
        '/dash_respo': (context) => Dashresponsable(),
        '/addTeam': (context) => addTeam(),
        '/manager/events': (context) => Dashevent(),
        '/manager/team': (context) => Dashteam(),
      },
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      darkTheme: ThemeData.dark(),
        //themeMode: ThemeMode.dark,
      //  home: Wrapper(),
          home: Login(),
          // home: Dashboard(),

     // home: DashboardResp(),
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

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
      NotificationPage(),
      Dashresponsable(),
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
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bell_fill),
        title: ("Notifications"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person_alt_circle),
        title: ("User"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
