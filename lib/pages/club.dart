// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Club extends StatefulWidget {
  Club({Key? key}) : super(key: key);

  @override
  _ClubState createState() => _ClubState();
}

class _ClubState extends State<Club> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tunivisions'),
          backgroundColor: Colors.deepPurple[900],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/club_logo/tunivisions.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Title(title: "About Us"),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Des clubs Tunivisions implantés dans plus d'une quarantaine d'universités étatiques et privées dispersées sur le territoire tunisien , comme ils sont surnommés les Tunimateurs ,et qui représentent aujourd'hui une marque d'une notoriété assez important",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Title(title: "News"),
                Image(
                  image: AssetImage('assets/club_post/tunivisions_post.jpg'),
                  height: 200,
                  width: 250,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Nous étions très ravis d'assister à une formation Gestion de Stress assurée par notre chère formatrice Insaf Ayari le 19 Janvier 2021✅Nous tenons à le remercier du fond du cœur pour son dévouement à nous passer l'information en toute lucidité .",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Title(title: "Events"),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayInFiniteScroll: true,
                  ),
                  items: [1, 2, 3, 4, 5, 6].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              print("clicked");
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image(
                                image: AssetImage(
                                    "assets/events/tunivisions($i).jpg"),
                                height: 400,
                                // fit: BoxFit.fitHeight,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Title(title: "Teams"),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayInFiniteScroll: true,
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              print("clicked");
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image(
                                image: AssetImage(
                                    "assets/club_team_image/tunivisions_team($i).jpg"),
                                width: 200,
                                // fit: BoxFit.fitHeight,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        )));
  }
}

class Title extends StatelessWidget {
  final String? title;

  Title({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
