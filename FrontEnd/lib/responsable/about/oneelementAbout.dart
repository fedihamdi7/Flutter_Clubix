import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_rental/responsable/about/EditAbout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class oneelementAbout extends StatefulWidget {
  final PlaceModel placeModel;
  oneelementAbout({this.placeModel});

  @override
  State<oneelementAbout> createState() => _oneelementAboutState();
}

class _oneelementAboutState extends State<oneelementAbout> {
  var about = [];
  getAbout() async {
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
    var url = "http://192.168.194.123:3000/api/manager/" + clubId + "/about";
    var uri = Uri.parse(url);
    var request = http.get(uri, headers: headers);
    var response = await request.timeout(Duration(seconds: 10));
    setState(() {
      about = jsonDecode(response.body);
    });
    // print(about[0]["description"]);
  }

  @override
  void initState() {
    super.initState();
    getAbout();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12,
      ),
      child: Container(
        height: 340,
        width: 500,
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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                // child: Image(
                //   height: 220,
                //   width: 150,
                //   fit: BoxFit.cover,
                //   // image: AssetImage(placeModel.imagePath),
                // ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Your Club Description",
                      style: textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      // style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(about[0]["description"]),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      // child: Row(
                      // TextButton(
                      //   style: TextButton.styleFrom(
                      //     primary: Colors.blue,
                      //   ),
                      //   onPressed: () { },
                      //   child: Text('TextButton'),
                      // )

                      child: ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            // Navigator.pushReplacementNamed(context, '/home');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editAbout(about[0]["description"])));
                          },
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      //  child: ButtonTheme(
                      //   height: 50,
                      //   child: RaisedButton(
                      //     onPressed: () {
                      //       // Navigator.pushReplacementNamed(context, '/home');
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => Bar()));
                      //     },
                      //     color: CupertinoColors.systemRed,
                      //     child: Text(
                      //       "Delete",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
