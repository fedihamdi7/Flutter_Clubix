import 'dart:convert';

import 'package:flutter/cupertino.dart';
// import 'package:home_rental/home.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/Screens/Templates/navigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //input controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    var uri = Uri.parse("http://192.168.194.123:3000/api/auth/login");
    var data = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    var request = http.post(uri,
        body: json.encode(data), headers: {"Content-Type": "application/json"});
    var response = await request.timeout(Duration(seconds: 10));
    // print(response.body);
    if (response.statusCode == 200) {
      //save response in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          "token", (json.decode(response.body)["token"]).toString());
      prefs.setString(
          "userId", (json.decode(response.body)["user"]["userId"]).toString());
      prefs.setString("club_id",
          (json.decode(response.body)["user"]["club_id"]).toString());
      prefs.setString(
          "type", (json.decode(response.body)["user"]["type"]).toString());

      // prefs.setString("user", (json.decode(response.body)["user"]).toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Bar()));
      Fluttertoast.showToast(
          msg: "You Are Logged In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0);
    }
    //get data from shared preferences
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
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: Text(
                        "New User ? Signup",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 30),
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
                          height: 60,
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
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: CupertinoColors.activeBlue),
                                      border: InputBorder.none),
                                ),
                              ),
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
                                ),
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
                                  // Navigator.pushReplacementNamed(context, '/home');
                                  _login();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Bar()));
                                },
                                color: CupertinoColors.activeBlue,
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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

input(text) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: CupertinoColors.activeBlue))),
    child: TextField(
      decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: CupertinoColors.activeBlue),
          border: InputBorder.none),
    ),
  );
}
