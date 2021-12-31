import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class editAbout extends StatefulWidget {
  String about;
  editAbout(this.about);
  @override
  _editAbout createState() => _editAbout();
}

class _editAbout extends State<editAbout> {
  var _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _aboutController.text = widget.about;
  }

  saveAbout() async {
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
    var body = {
      "description": _aboutController.text,
    };

    var uri = Uri.parse(
        "http://192.168.194.123:3000/api/manager/" + clubId + "/about");
    var request = http.put(uri, body: json.encode(body), headers: headers);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Description'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: CupertinoColors.activeBlue))),
              child: TextField(
                controller: _aboutController,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "About",
                    hintStyle: TextStyle(color: CupertinoColors.activeBlue),
                    border: InputBorder.none),
              ),
            ),
            TextButton(
                onPressed: () {
                  saveAbout();
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
