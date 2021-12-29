import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';

class BestOffer extends StatelessWidget {
  final PlaceModel placeModel;
  BestOffer({this.placeModel});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
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
                  image: AssetImage(placeModel.imagePath),
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
                    "Post",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                   "Welcome to clubix. A website for all students that are a part of iset bizerte where you can find all the clubs and learn about them and there events ."
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
    );
  }
}
