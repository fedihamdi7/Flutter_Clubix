// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clubix/pages/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Colors.deepPurple,
                          Colors.purple, 
                          Colors.orange]
                          )
                          ),
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
                              input("Email"),
                              input("Password"),
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
                              color: Colors.purple[900]),
                          child: Center(
                            child: ButtonTheme(
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  // Navigator.pushReplacementNamed(context, '/home');
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                                },
                                color: Colors.purple[900],
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
        border: Border(bottom: BorderSide(color: Colors.purpleAccent))),
    child: TextField(
      decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.purple),
          border: InputBorder.none),
    ),
  );
}
