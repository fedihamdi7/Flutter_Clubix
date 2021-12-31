import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/component/appBarActionItems.dart';

import 'package:home_rental/component/header_events.dart';
import 'package:http/http.dart' as http;

import 'package:home_rental/component/siderespMenu.dart';
import 'package:home_rental/config/responsive.dart';
import 'package:home_rental/config/size_config.dart';
import 'package:home_rental/responsable/event/oneelementevent.dart';
import 'package:home_rental/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashevent extends StatefulWidget {
  @override
  State<Dashevent> createState() => _DasheventState();
}

class _DasheventState extends State<Dashevent> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var events = [];
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
    var url = "http://192.168.194.123:3000/api/manager/" + clubId + "/events";
    var uri = Uri.parse(url);
    var request = http.get(uri, headers: headers);
    var response = await request.timeout(Duration(seconds: 10));
    setState(() {
      events = jsonDecode(response.body)[0]["events"];
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
                        HeaderEvents(),
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
                                    itemCount: events.length,
                                    itemBuilder: (context, index) {
                                      return oneelementevent(
                                        placeModel: events[index],
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: SizeConfig.blockSizeVertical * 5,
                        // ),
                        // FloatingActionButton(
                        //   backgroundColor: Colors.blue,
                        //   foregroundColor: Colors.black,
                        //   onPressed: () {
                        //     // Respond to button press

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

















































//   @override

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: ListView(
//             shrinkWrap: true,
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
            
//               //about us
//    SizedBox(height: 50),
              
//               SizedBox(height: 30),
//               Oneelement(
//                 placeModel: placeCollection[2],
//               ),
//               SizedBox(height: 60),
            
              
           
          
         
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  

// }
