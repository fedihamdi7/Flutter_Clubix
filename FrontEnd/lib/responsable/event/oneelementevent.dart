import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_rental/responsable/event/EditEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class oneelementevent extends StatefulWidget {
  final dynamic placeModel;
  oneelementevent({this.placeModel});

  @override
  State<oneelementevent> createState() => _oneelementeventState();
}

class _oneelementeventState extends State<oneelementevent> {
  deleteEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    String clubId = prefs.getString("club_id");
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
    var uri = Uri.parse("http://192.168.194.123:3000/api/manager/" +
        widget.placeModel["event_id"] +
        "/events");
    var request = http.delete(uri, headers: headers);
    Navigator.popAndPushNamed(context,'/manager/events');
  }

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
                  image: AssetImage(
                      "asset/img/events/" + widget.placeModel["event_img"]),
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
                      widget.placeModel["event_name"],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(widget.placeModel["event_date"]),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        editEvent(widget.placeModel)));
                          },
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: ButtonTheme(
                        height: 50,
                        buttonColor: Colors.red,
                        child: RaisedButton(
                          onPressed: () {
                            deleteEvent();
                          },
                          color: Colors.red[800],
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
