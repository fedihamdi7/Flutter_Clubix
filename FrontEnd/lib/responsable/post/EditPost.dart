import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart';

class editPost extends StatefulWidget {
  dynamic post;
  editPost(this.post);
  @override
  _editPost createState() => _editPost();
}

class _editPost extends State<editPost> {
  //input controller
  TextEditingController _postTitleController = TextEditingController();
  TextEditingController _postDescriptionController = TextEditingController();
  //current image

  //XFile
  XFile _file;
  @override
  void initState() {
    super.initState();
    _postTitleController.text = widget.post['post_title'];
    _postDescriptionController.text = widget.post['post_description'];
  }

  send(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    String clubId = prefs.getString("club_id");
 

    var stream = new http.ByteStream(DelegatingStream.typed(_file.openRead()));
    var length = await _file.length();
    var uri = Uri.parse(
        "http://192.168.194.123:3000/api/manager/" + clubId + "/post");
    var request = new http.MultipartRequest("PUT", uri);
    var multipartFile = new http.MultipartFile('post_img', stream, length,
        filename: basename(_file.path));
    request.files.add(multipartFile);
    request.fields['post_title'] = _postTitleController.text;
    request.fields['post_description'] = _postDescriptionController.text;
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
                    controller: _postTitleController,
                    decoration: InputDecoration(
                      hintText: "Post Title",
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
                    controller: _postDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Post Description",
                      hintStyle: TextStyle(color: CupertinoColors.activeBlue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text("Current Image"),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 200,
                  //   width: 200,
                  //   child: Image(
                  //     height: 220,
                  //     width: 150,
                  //     fit: BoxFit.cover,
                  //     image: AssetImage(
                  //         "asset/img/posts/" + widget.post["post_img"]),
                  //   ),
                  // ),
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
