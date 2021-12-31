import 'package:flutter/material.dart';
import 'package:home_rental/admin/club/addCub.dart';
import 'package:home_rental/style/style.dart';

class HeadClub extends StatelessWidget {
  const HeadClub({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PrimaryText(
                      text: 'Clubs', size: 30, fontWeight: FontWeight.w800),
                  SizedBox(width: 200),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addClub()),
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ]),
      ),
      Spacer(
        flex: 1,
      ),
    ]);
  }
}
