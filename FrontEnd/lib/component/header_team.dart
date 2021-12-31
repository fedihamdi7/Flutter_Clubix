import 'package:flutter/material.dart';
import 'package:home_rental/config/responsive.dart';
import 'package:home_rental/responsable/event/addEvent.dart';
import 'package:home_rental/responsable/team/addTeam.dart';
import 'package:home_rental/style/colors.dart';
import 'package:home_rental/style/style.dart';

class HeaderTeam extends StatelessWidget {
  const HeaderTeam({
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
                      text: 'Team', size: 30, fontWeight: FontWeight.w800),
                  SizedBox(width: 220),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addTeam()),
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // PrimaryText(
              //   text: 'Welcome Manager',
              //   size: 16,
              //   fontWeight: FontWeight.w400,
              //   color: AppColors.secondary,
              // )
            ]),
      ),
      Spacer(
        flex: 1,
      ),
    ]);
  }
}
