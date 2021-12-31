import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:home_rental/Models/constants.dart';
import 'package:home_rental/Models/ViewModel/Post.dart';
import 'package:http/http.dart';

class PlaceDetails extends StatefulWidget {
  final dynamic placeModel;
  PlaceDetails({@required this.placeModel});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  dynamic club = {};

  void getClub() async {
    var uri = Uri.parse("http://192.168.194.123:3000/api/club/getOneClub/" +
        widget.placeModel["_id"]);
    print(uri);
    var request = get(uri);
    var response = await request;
    dynamic data = jsonDecode(response.body);
    setState(() {
      this.club = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getClub();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.placeModel['title'],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "asset/img/club/" + widget.placeModel['image']),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        widget.placeModel['title'],
                        style: textTheme.headline4.apply(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),
                Text(
                  "About",
                  style: textTheme.headline5,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  club[0]['description'],
                  style: textTheme.subtitle1.apply(
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 50),

                //Post
                Text(
                  "Post",
                  style: textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Container(
                    height: 220,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image(
                              height: 220,
                              width: 160,
                              fit: BoxFit.cover,
                              image: AssetImage("asset/img/posts/" +
                                  club[0]["post"][0]["post_img"]),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  club[0]["post"][0]["post_title"],
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  club[0]["post"][0]["post_description"],
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Flexible(
                                  child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Events
                SizedBox(height: 60),
                Text(
                  "Events",
                  style: textTheme.headline5,
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: club[0]["events"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image(
                            height: 220,
                            width: 220,
                            fit: BoxFit.cover,
                            image: AssetImage("asset/img/events/" +
                                club[0]["events"][index]["event_img"]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Our Team",
                  style: textTheme.headline5,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: club[0]["team"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image(
                                  width: 65,
                                  fit: BoxFit.cover,
                                  image: AssetImage("asset/img/team/" +
                                      club[0]["team"][index]["team_img"]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    club[0]["team"][index]["team_titre"],
                                    style: textTheme.caption,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    club[0]["team"][index]["team_name"],
                                    style: textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    FlutterIcons.comment_dots_faw5s,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
