import 'package:flutter/material.dart';
import 'package:home_rental/responsable/event/addEvent.dart';
import 'package:home_rental/style/style.dart';

class HeaderEvents extends StatelessWidget {
  const HeaderEvents({
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
                      text: 'Events', size: 30, fontWeight: FontWeight.w800),
                  SizedBox(width: 200),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addEvent()),
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
