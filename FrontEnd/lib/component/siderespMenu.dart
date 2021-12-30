//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_rental/Screens/HomePage.dart';
import 'package:home_rental/Screens/Templates/Dashresponsable.dart';
import 'package:home_rental/config/size_config.dart';
import 'package:home_rental/Screens/Templates/dashboard.dart';
import 'package:home_rental/responsable/about/dashaboutus.dart';

import 'package:home_rental/responsable/event/dashevent.dart';
import 'package:home_rental/responsable/post/dashpost.dart';
import 'package:home_rental/responsable/team/dashteam.dart';
import 'package:home_rental/style/colors.dart';

class SiderespMenu extends StatelessWidget {
  const SiderespMenu({
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
                 onPressed: () { Navigator.push(
                 context,
                MaterialPageRoute(builder: (context) =>Dashresponsable() ),
                  );}),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/about.svg',
                    color: AppColors.iconGray,
                  ),
                 onPressed: () { Navigator.push(
                 context,
                MaterialPageRoute(builder: (context) => Dashaboutus()),
                  );}),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/event.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dashevent()),
  );}),
         IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/post.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dashpost()),
  );}),
    IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'asset/images/team.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dashteam()),
  );}),
             
            ],
          ),
        ),
      ),
    );
  }
}