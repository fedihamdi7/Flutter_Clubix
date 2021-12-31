import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_rental/admin/user/editUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dashuser.dart';

class oneelementuser extends StatefulWidget {
  final dynamic user;
  oneelementuser({this.user});

  @override
  State<oneelementuser> createState() => _oneelementuserState();
}

class _oneelementuserState extends State<oneelementuser> {
  deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
    var uri = Uri.parse("http://192.168.194.123:3000/api/admin_user/" +
        widget.user["_id"] +
        "/deleteuser");
    var request = http.delete(uri, headers: headers);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashuser()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12,
      ),
      child: Container(
        height: 220,
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
                child: Image(
                  height: 220,
                  width: 150,
                  fit: BoxFit.cover,
                  image:
                      AssetImage("asset/img/avatar/" + widget.user['user_img']),
                ),
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
                      widget.user['name'],
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(widget.user['email']),
                    // Text("User password"),
                    Text(widget.user['type']),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: ButtonTheme(
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        editUser(widget.user)));
                          },
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: ButtonTheme(
                        height: 40,
                        buttonColor: Colors.red,
                        child: RaisedButton(
                          onPressed: () {
                            deleteUser();
                          },
                          color: Colors.red[800],
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
