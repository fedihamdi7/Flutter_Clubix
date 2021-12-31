// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rental/Screens/PlaceDetails.dart';
import 'package:home_rental/template/club_card.dart';
import 'package:http/http.dart';

class ClubsList extends StatefulWidget {
  @override
  _ClubsListState createState() => _ClubsListState();
}

class _ClubsListState extends State<ClubsList> {
  dynamic data = [];
  void getClubs() async {
    Response response = await get(
        Uri.parse("http://192.168.194.123:3000/api/allclub/getAllClub"));
    dynamic responsedata = jsonDecode(response.body);
    setState(() {
      this.data = responsedata;
    });
  }

  @override
  void initState() {
    super.initState();
    getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Clubs"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetails(placeModel: data[index]),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(
                      0.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage("asset/img/club/${data[index]['image']}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.adjust,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              SizedBox(width: 7),
                              Text(data[index]['title'],
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
