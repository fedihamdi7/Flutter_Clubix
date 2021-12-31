import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Signup Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacementNamed(context, '/login');
    }
    response.stream.transform(utf8.decoder).listen((value) {});
    return response;
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
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Join Us",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        "You have an account ? login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
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
                                        hintText: "Username",
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
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        hintText: "Email",
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
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        hintText: "Password",
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
                                    controller: _typeController,
                                    decoration: InputDecoration(
                                        hintText: "Type : (user/manager)",
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
                                  SignUp(
                                      image,
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _typeController.text,
                                      context);
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

// input(text) {
//   return Form(
//     key: Key(text),
//     child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             border:
//                 Border(bottom: BorderSide(color: CupertinoColors.activeBlue))),
//         child: TextField(
//           decoration: InputDecoration(
//               hintText: text,
//               hintStyle: TextStyle(color: CupertinoColors.activeBlue),
//               border: InputBorder.none),
//         )),
//   );
// }
