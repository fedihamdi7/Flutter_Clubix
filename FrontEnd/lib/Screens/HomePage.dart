import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:home_rental/Models/ViewModel/AboutUspageHome.dart';
// import 'package:home_rental/Models/ViewModel/RecentAddedHome.dart';
// import 'package:home_rental/Models/ViewModel/RecentEvent.dart';
// import 'package:home_rental/Models/constants.dart';
import 'package:home_rental/Screens/PlaceDetails.dart';
import 'package:home_rental/login.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:home_rental/Screens/Templates/Dashresponsable.dart';
// import 'package:home_rental/Screens/Templates/ClubsList.dart';
// import 'package:home_rental/Screens/HomePage.dart';
// import 'package:home_rental/Screens/Templates/NotificationsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic events = [];
  dynamic clubs = [];

  void latestEvents() async {
    var uri = Uri.parse("http://192.168.194.123:3000/api/home/getLatestEvents");
    var request = get(uri);
    var response = await request;
    dynamic data = jsonDecode(response.body);
    setState(() {
      this.events = data;
    });
  }

  void activeClubs() async {
    var uri = Uri.parse("http://192.168.194.123:3000/api/home/getClub");
    var request = get(uri);
    var response = await request;
    dynamic data = jsonDecode(response.body);
    setState(() {
      this.clubs = data;
    });
  }

  @override
  void initState() {
    super.initState();
    latestEvents();
    activeClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blue,
        actions: [
          // aad logout icon
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              // Navigator.pushNamed(context, '/login');
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => new Login()));
            },
          ),
        ],
      ),
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

              //about us
              SizedBox(height: 50),

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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        child: Container(
                          height: 250,
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Hero(
                                      tag: events[index]["events"]
                                          ["event_name"],
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image(
                                          height: 250,
                                          width: 350,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "asset/img/events/" +
                                                  events[index]["events"]
                                                      ["event_img"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  itemCount: clubs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlaceDetails(placeModel: clubs[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        child: Container(
                          height: 380,
                          width: 300,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(3, 5),
                              ),
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(-3, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Hero(
                                      tag: clubs[index]["title"],
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image(
                                          height: 150,
                                          width: 250,
                                          fit: BoxFit.cover,
                                          image: AssetImage("asset/img/club/" +
                                              clubs[index]["image"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  clubs[index]["title"],
                                  // style: events.headline6.apply(
                                  //   color: Colors.black,
                                  // ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  clubs[index]["description"],
                                  // style: textTheme.bodyText1.apply(
                                  //   color: Colors.black45,
                                  // ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
// ---------------------------------------------------------------

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
