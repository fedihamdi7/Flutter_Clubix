import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_rental/admin/club/dashclub.dart';
import 'package:home_rental/admin/club/editClub.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class oneelementclub extends StatefulWidget {
  final dynamic club;
  oneelementclub({this.club});

  @override
  State<oneelementclub> createState() => _oneelementclubState();
}

class _oneelementclubState extends State<oneelementclub> {
  deleteClub() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
    var uri = Uri.parse("http://192.168.194.123:3000/api/admin/" +
        widget.club["_id"] +
        "/clubs");
    var request = http.delete(uri, headers: headers);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashclub()));
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
                  image: AssetImage("asset/img/club/" + widget.club['image']),
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
                      widget.club['title'],
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.club['description'],
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
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
                                    builder: (context) =>
                                        editClub(widget.club)));
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
                        height: 40,
                        buttonColor: Colors.red,
                        child: RaisedButton(
                          onPressed: () {
                            deleteClub();
                          },
                          color: Colors.red[800],
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
