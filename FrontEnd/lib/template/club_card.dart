// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ClubCard extends StatelessWidget {
  final String name;
  final String logo;
  ClubCard({
    this.name,
     this.logo,
  });
  ClubCard.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        logo = json['logo'];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          image: AssetImage("assets/club_logo/$logo"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Align(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 5.0),
          //     child: Text(
          //       name,
          //       style: TextStyle(
          //         fontSize: 0,
          //         color: Colors.white,
          //       ),
          //       overflow: TextOverflow.ellipsis,
          //       maxLines: 2,
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //   alignment: Alignment.center,
          // ),
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
                      Text(name, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }

  toList() {}
}
