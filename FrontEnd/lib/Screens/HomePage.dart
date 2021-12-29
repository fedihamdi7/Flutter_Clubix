import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:home_rental/Models/ViewModel/AboutUspageHome.dart';
import 'package:home_rental/Models/ViewModel/RecentAddedHome.dart';
import 'package:home_rental/Models/ViewModel/RecentEvent.dart';
import 'package:home_rental/Models/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:home_rental/Screens/Templates/Dashresponsable.dart';
import 'package:home_rental/Screens/Templates/BookedPage.dart';
import 'package:home_rental/Screens/HomePage.dart';
import 'package:home_rental/Screens/Templates/NotificationsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
   
}

class _HomePageState extends State<HomePage> {
    PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
             
                  children: [
                    // Container(
                    //   height: 55,
                    //   width: 55,
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[300],
                    //     borderRadius: BorderRadius.circular(18),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         blurRadius: 15,
                    //         color: Colors.black.withOpacity(0.3),
                    //         offset: Offset(5, 5),
                    //       )
                    //     ],
                    //   ),
                    //   child: Icon(
                    //     FlutterIcons.th_large_faw,
                    //     color: kCustomBlackColor,
                    //   ),
                    //  ),
                    
                     
             // SizedBox(height: 50),

                    
                  ],
                ),
              ),
              //about us
   SizedBox(height: 50),
              
              SizedBox(height: 30),
              BestOffer(
                placeModel: placeCollection[2],
              ),
              SizedBox(height: 60),
             //events
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                 
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(-5, 10),
                            )
                          ],
                        ),
                        child: Icon(
                          FlutterIcons.sliders_h_faw5s,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Events",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                   
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 350,
                width: 350,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  children: [
                    RecentEvent(
                      placeModel: placeCollection[0],
                    ),
                   RecentEvent(
                      placeModel: placeCollection[1],
                    ),
                  ],
                ),
              ),




// -----------------------------------------------
 SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most active Clubs",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                   
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 350,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  children: [
                    RecentAdded(
                      placeModel: placeCollection[0],
                    ),
                    RecentAdded(
                      placeModel: placeCollection[1],
                    ),
                  ],
                ),
              ),
// ---------------------------------------------------------------

          SizedBox(height: 50),
          PersistentTabView(
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
    ),
            ],
          ),
        ),
      ),
    );
  }
  
  List<Widget> _buildScreens() {
    return [
      HomePage(),
      BookedPage(),
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
