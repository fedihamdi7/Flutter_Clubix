import 'package:flutter/material.dart';
import 'package:home_rental/admin/user/oneelementUser.dart';
import 'package:home_rental/component/appBarActionItems.dart';
import 'package:home_rental/component/header_user.dart';
import 'package:home_rental/component/sideMenu.dart';
import 'package:home_rental/config/responsive.dart';
import 'package:home_rental/config/size_config.dart';
import 'package:home_rental/style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Dashuser extends StatefulWidget {
  @override
  State<Dashuser> createState() => _DashuserState();
}

class _DashuserState extends State<Dashuser> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var users;
  getUsers() async {
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
    var url = "http://192.168.194.123:3000/api/admin_user/getUsers";
    var uri = Uri.parse(url);
    var request = http.get(uri, headers: headers);
    var response = await request.timeout(Duration(seconds: 10));
    setState(() {
      users = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SideMenu()),
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
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderUser(),
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
                                    itemCount: users.length,
                                    itemBuilder: (context, index) {
                                      return oneelementuser(
                                        user: users[index],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
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
