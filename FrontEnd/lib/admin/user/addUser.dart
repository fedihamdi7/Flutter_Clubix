import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_rental/admin/user/dashuser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';

class addUser extends StatefulWidget {
  @override
  _addUser createState() => _addUser();
}

class _addUser extends State<addUser> {
  //input controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _typeController = TextEditingController();

  //XFile
  XFile _file;

  Future<dynamic> SignUp(File imageFile, String name, String email,
      String password, String type, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.194.123:3000/api/auth/signup");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('user_img', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['type'] = type;
    var response = await request.send();
    Fluttertoast.showToast(
        msg: "User Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    response.stream.transform(utf8.decoder).listen((value) {});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
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
                      controller: _typeController,
                      decoration: InputDecoration(
                        hintText: "Type : (user/manager)",
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
                  onPressed: () async{
                    File image = File(_file.path);
                    await SignUp(
                        image,
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                        _typeController.text,
                        context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashuser()));
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ]),
    );
  }
}
