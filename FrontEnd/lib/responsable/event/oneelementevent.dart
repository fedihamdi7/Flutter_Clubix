import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:home_rental/Models/Datamodel/PlaceModel.dart';
import 'package:flutter/cupertino.dart';
// import 'package:home_rental/home.dart';
import 'package:home_rental/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:home_rental/Screens/Templates/navigationBar.dart';
import 'package:home_rental/responsable/event/EditEvent.dart';
import 'package:home_rental/responsable/team/editTeam.dart';

class oneelementevent extends StatelessWidget {
  final PlaceModel placeModel;
  oneelementevent({this.placeModel});

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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image(
                  height: 220,
                  width: 150,
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
                      "Event Date ✨",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(""),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                                                      // child: Row(
                                // TextButton(
                                //   style: TextButton.styleFrom(
                                //     primary: Colors.blue,
                                //   ),
                                //   onPressed: () { },
                                //   child: Text('TextButton'),
                                // )

                           child: ButtonTheme(
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    // Navigator.pushReplacementNamed(context, '/home');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => editEvent()));
                                  },
                                  color: CupertinoColors.activeBlue,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      
                              //  child: ButtonTheme(
                              //   height: 50,
                              //   child: RaisedButton(
                              //     onPressed: () {
                              //       // Navigator.pushReplacementNamed(context, '/home');
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => Bar()));
                              //     },
                              //     color: CupertinoColors.systemRed,
                              //     child: Text(
                              //       "Delete",
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          ),
                    // ),
                    
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
