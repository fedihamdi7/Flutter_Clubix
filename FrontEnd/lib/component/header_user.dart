import 'package:flutter/material.dart';
import 'package:home_rental/admin/user/addUser.dart';
import 'package:home_rental/style/style.dart';

class HeaderUser extends StatelessWidget {
  const HeaderUser({
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
                      text: 'Users', size: 30, fontWeight: FontWeight.w800),
                  SizedBox(width: 200),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addUser()),
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
