import 'package:flutter/material.dart';
import 'package:home_rental/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => new Login()));
            }),
        SizedBox(width: 10),
      ],
    );
  }
}
