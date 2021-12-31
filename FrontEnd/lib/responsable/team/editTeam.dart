import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class editTeam extends StatefulWidget {
  dynamic team;
  editTeam(this.team);
  @override
  _editTeam createState() => _editTeam();
}

class _editTeam extends State<editTeam> {
  //input controller
  TextEditingController _teamName = TextEditingController();
  TextEditingController _teamTitre = TextEditingController();
  TextEditingController _teamFB = TextEditingController();
  TextEditingController _teamInsta = TextEditingController();
  TextEditingController _teamLinked = TextEditingController();
  TextEditingController _teamTwitter = TextEditingController();
//XFile
  XFile _file;
  @override
  void initState() {
    super.initState();
    _teamName.text = widget.team['team_name'];
    _teamTitre.text = widget.team['team_titre'];
    _teamFB.text = widget.team['team_fb'];
    _teamInsta.text = widget.team['team_insta'];
    _teamLinked.text = widget.team['team_linkedin'];
    _teamTwitter.text = widget.team['team_twitter'];
  }

  send(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    String teamId = widget.team['team_id'];

    var stream = new http.ByteStream(DelegatingStream.typed(_file.openRead()));
    var length = await _file.length();
    var uri = Uri.parse(
        "http://192.168.194.123:3000/api/manager/" + teamId + "/team");
    var request = new http.MultipartRequest("PUT", uri);
    var multipartFile = new http.MultipartFile('team_img', stream, length,
        filename: basename(_file.path));
    request.files.add(multipartFile);
    request.fields['team_id'] = teamId;
    request.fields['team_name'] = _teamName.text;
    request.fields['team_titre'] = _teamTitre.text;
    request.fields['team_fb'] = _teamFB.text;
    request.fields['team_insta'] = _teamInsta.text;
    request.fields['team_linkedin'] = _teamLinked.text;
    request.fields['team_twitter'] = _teamTwitter.text;
    request.headers['Authorization'] = 'Bearer ' + token;
    request.headers['userId'] = userId;
    request.headers['flutter'] = "true";
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Team'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _teamName,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle:
                              TextStyle(color: CupertinoColors.activeBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _teamTitre,
                        decoration: InputDecoration(
                          hintText: "Titre",
                          hintStyle:
                              TextStyle(color: CupertinoColors.activeBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: Text('Upload Image'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[800],
                          ),
                          onPressed: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            setState(() {
                              _file = pickedFile;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _teamFB,
                        decoration: InputDecoration(
                          hintText: "Facebook",
                          hintStyle:
                              TextStyle(color: CupertinoColors.activeBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _teamInsta,
                        decoration: InputDecoration(
                          hintText: "Instagram",
                          hintStyle:
                              TextStyle(color: CupertinoColors.activeBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _teamLinked,
                        decoration: InputDecoration(
                          hintText: "Linked In",
                          hintStyle:
                              TextStyle(color: CupertinoColors.activeBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _teamTwitter,
                        decoration: InputDecoration(
                          hintText: "Twitter",
                          hintStyle:
                              TextStyle(color: CupertinoColors.activeBlue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      File image = File(_file.path);
                      send(image);
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
