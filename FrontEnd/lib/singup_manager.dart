import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart';

class SignupManager extends StatefulWidget {
  @override
  _SignupManagerState createState() => _SignupManagerState();
}

class _SignupManagerState extends State<SignupManager> {
  //input fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  XFile _file;

  SignUp(File imageFile, String name, String description, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId");

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.194.123:3000/api/auth/clubManager");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    request.headers['user_id'] = userId;
    request.fields['title'] = _nameController.text;
    request.fields['description'] = _descriptionController.text;
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Color(0xff1d2434),
          Colors.blue,
          CupertinoColors.activeBlue
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Create Your Club",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tell Us about your Club",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.pushReplacementNamed(context, '/login');
                  //     },
                  //     child: Text(
                  //       "You have an account ? login",
                  //       style: TextStyle(color: Colors.white, fontSize: 18),
                  //     )),
                ],
              ),
            ),
            SizedBox(height: 0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  CupertinoColors.activeBlue))),
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                        hintText: "Club Name",
                                        hintStyle: TextStyle(
                                            color: CupertinoColors.activeBlue),
                                        border: InputBorder.none),
                                  )),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  CupertinoColors.activeBlue))),
                                  child: TextField(
                                    controller: _descriptionController,
                                    decoration: InputDecoration(
                                        hintText: "Club Description",
                                        hintStyle: TextStyle(
                                            color: CupertinoColors.activeBlue),
                                        border: InputBorder.none),
                                  )),
                              TextButton(
                                child: Text('Upload Image'),
                                onPressed: () async {
                                  final pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    _file = pickedFile;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: CupertinoColors.activeBlue),
                          child: Center(
                            child: ButtonTheme(
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  File image = File(_file.path);
                                  SignUp(image, _nameController.text,
                                      _descriptionController.text, context);
                                },
                                color: CupertinoColors.activeBlue,
                                child: Text(
                                  "Signup",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
