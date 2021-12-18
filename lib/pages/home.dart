// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CLUBIX"),
          backgroundColor: Colors.deepPurple[900],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/4c.jpg"),
                    ),
                    Title(title: "About Us"),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Welcome to clubix. A website for all students that are a part of  iset bizerte where you can find all the clubs and learn about them and there events .This website does not only give you an opportunity to develop yourself in all aspects but it also help you to be more active and assure you a better experience at college. So Join us to be a part of our family",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
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
                      items: [
                        "4c(1)",
                        "4c(2)",
                        "mcncom(1)",
                        "mcncom(3)",
                        "tunivisions(1)"
                      ].map((i) {
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
                                  child: Container(
                                    child: Image(
                                      image: AssetImage("assets/events/$i.jpg"),
                                      height: 400,
                                      fit: BoxFit.fitHeight,
                                    ),
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
                    Image(
                      image: AssetImage("assets/stats.png"),
                      // height: 100.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Title(title: "Clubs"),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 310.0,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayInFiniteScroll: true,
                      ),
                      items: [
                        "4c.jpg",
                        "ieee.jpeg",
                        "tunivisions.jpg",
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/club");
                                },
                                child: Container(
                                  height: 110.0,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    child: Image(
                                      image: AssetImage("assets/club_logo/$i"),
                                      height: 150.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/clubs_list");
                      },
                      child: Center(
                        child: Text(
                          "See all clubs",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.deepPurple[900],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Image(
                      image: AssetImage("assets/footer.png"),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
