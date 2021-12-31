import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_rental/style/colors.dart';

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
            icon: Icon(Icons.logout, color: Colors.black), onPressed: () {}),
        SizedBox(width: 10),
        // Row(children: [
        //   CircleAvatar(
        //     radius: 17,
        //     backgroundColor: Colors.black,
        //     // backgroundImage: NetworkImage(
        //     //   'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
        //     // ),
        //   ),
        //   Icon(Icons.arrow_drop_down_outlined, color: AppColors.black)
        // ]),
      ],
    );
  }
}
