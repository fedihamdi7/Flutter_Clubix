// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/template/club_card.dart';
// import 'package:http/http.dart';

class ClubsList extends StatefulWidget {
  @override
  _ClubsListState createState() => _ClubsListState();
}

class _ClubsListState extends State<ClubsList> {
  Map data = {
    "name" : "IEEE",
    "logo" : "image1.jpg",
  };
  // void getClubs() async {
  //   Response response =
  //       await get(Uri.parse("http://localhost:3000/clubs/clubs_list"));
  //   Map data = jsonDecode(response.body);
  //   setState(() {
  //     this.data = data;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return ClubCard(
            name: data['name'],
            logo: data['logo'],
          );
        },
      ),
    );
  }
}

