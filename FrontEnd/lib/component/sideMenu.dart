import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_rental/Screens/HomePage.dart';
import 'package:home_rental/admin/club/dashclub.dart';
import 'package:home_rental/admin/user/dashuser.dart';
import 'package:home_rental/config/size_config.dart';
import 'package:home_rental/style/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
               height: 100,
               alignment: Alignment.topCenter,
               width: double.infinity,
               padding: EdgeInsets.only(top: 20),
               child: SizedBox(
                    width: 35,
                    height: 20,
                    child: SvgPicture.asset('asset/images/mac-action.svg'),
                  ),
             ),
            
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/home.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );}),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/user.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dashuser()),
  );}),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/club.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dashclub()),
  );}),
             
            ],
          ),
        ),
      ),
    );
  }
}