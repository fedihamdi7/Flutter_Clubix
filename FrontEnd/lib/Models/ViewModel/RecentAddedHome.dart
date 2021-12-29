import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:home_rental/Screens/PlaceDetails.dart';

class RecentAdded extends StatelessWidget {
  final PlaceModel placeModel;
  RecentAdded({this.placeModel});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetails(placeModel: placeModel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12,
        ),
        child: Container(
          height: 380,
          width: 300,
          decoration: BoxDecoration(
            // color: Colors.blue,
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(3, 5),
              ),

              BoxShadow(
                blurRadius: 10,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(-3, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: placeModel.title,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(placeModel.imagePath),
                        ),
                      ),
                    ),
                                     ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  placeModel.title,
                  style: textTheme.headline6.apply(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  placeModel.details,
                  style: textTheme.bodyText1.apply(
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
