import 'package:flutter/material.dart';
import 'package:home_rental/component/appBarActionItems.dart';

import 'package:home_rental/component/header_team.dart';
import 'package:home_rental/component/siderespMenu.dart';
import 'package:home_rental/config/responsive.dart';
import 'package:home_rental/config/size_config.dart';
import 'package:home_rental/responsable/team/oneelementTeam.dart';
import 'package:home_rental/responsable/team/addTeam.dart';
import 'package:home_rental/style/colors.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Dashteam extends StatefulWidget {
  @override
  State<Dashteam> createState() => _DashteamState();
}

class _DashteamState extends State<Dashteam> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  dynamic team;
  getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    String clubId = prefs.getString("club_id");
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
    var url = "http://192.168.194.123:3000/api/manager/" + clubId + "/team";
    var uri = Uri.parse(url);
    var request = http.get(uri, headers: headers);
    var response = await request.timeout(Duration(seconds: 10));
    setState(() {
      team = jsonDecode(response.body)["team"];
    });
  }

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SiderespMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: AppColors.black)),
              actions: [
                AppBarActionItems(),
              ],
            )
          : PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SiderespMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderTeam(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 450,
                                child: ListView.builder(
                                    itemCount: team.length,
                                    itemBuilder: (context, index) {
                                      return oneelementTeam(
                                        placeModel: team[index],
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        // SizedBox(
                        //   height: SizeConfig.blockSizeVertical * 3,
                        // ),
                        // SizedBox(
                        //   height: SizeConfig.blockSizeVertical * 5,
                        // ),
                        // FloatingActionButton(
                        //   backgroundColor: Colors.blue,
                        //   foregroundColor: Colors.black,
                        //   onPressed: () {
                        //     // Respond to button press
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => addTeam()),
                        //     );
                        //   },
                        //   child: Icon(Icons.add),
                        // )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
