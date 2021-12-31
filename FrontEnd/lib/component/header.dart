import 'package:flutter/material.dart';
import 'package:home_rental/style/style.dart';

class Header extends StatelessWidget {
  const Header({
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
                      text: 'Dashboard', size: 30, fontWeight: FontWeight.w800),
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
