import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class editEvent extends StatefulWidget {
  dynamic event;
  editEvent(this.event);
  @override
  _editEvent createState() => _editEvent();
}

class _editEvent extends State<editEvent> {
  //input controller
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
//XFile
  XFile _file;
  @override
  void initState() {
    super.initState();
    _eventNameController.text = widget.event['event_name'];
    _eventDateController.text = widget.event['event_date'];
  }

  send(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    String clubId = prefs.getString("club_id");
    String eventId = widget.event['event_id'];

    var stream = new http.ByteStream(DelegatingStream.typed(_file.openRead()));
    var length = await _file.length();
    var uri = Uri.parse(
        "http://192.168.194.123:3000/api/manager/" + eventId + "/events");
    var request = new http.MultipartRequest("PUT", uri);
    var multipartFile = new http.MultipartFile('event_img', stream, length,
        filename: basename(_file.path));
    request.files.add(multipartFile);
    request.fields['event_name'] = _eventNameController.text;
    request.fields['event_date'] = _eventDateController.text;
    request.fields['event_id'] = eventId;
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
        title: Text('Edit Event'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      hintText: "Event Title",
                      hintStyle: TextStyle(color: CupertinoColors.activeBlue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _eventDateController,
                    decoration: InputDecoration(
                      hintText: "Event Date",
                      hintStyle: TextStyle(color: CupertinoColors.activeBlue),
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
    );
  }
}
