import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_rental/admin/club/dashclub.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class addClub extends StatefulWidget {
  @override
  _addClub createState() => _addClub();
}

class _addClub extends State<addClub> {
  //input controllers
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  //XFile
  XFile _file;

  Future<dynamic> SignUp(
      File imageFile, String title, String description, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.194.123:3000/api/admin/clubs");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.headers['Authorization'] = 'Bearer ' + token;
    request.headers['userId'] = userId;
    request.headers['flutter'] = "true";
    var response = await request.send();
    Fluttertoast.showToast(
        msg: "User Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    response.stream.transform(utf8.decoder).listen((value) {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashclub()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Club'),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
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
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
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
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: "Description",
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
                  onPressed: () async {
                    File image = File(_file.path);
                    await SignUp(image, _titleController.text,
                        _descriptionController.text, context);
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ]),
    );
  }
}
