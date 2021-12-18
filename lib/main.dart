// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clubix/pages/club.dart';
import 'package:clubix/pages/clubs_list.dart';
import 'package:clubix/pages/login.dart';
import 'package:clubix/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:clubix/pages/home.dart';
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => Home(),
        '/club': (context) => Club(),
        '/clubs_list': (context) => ClubsList(),
      },
    ));

