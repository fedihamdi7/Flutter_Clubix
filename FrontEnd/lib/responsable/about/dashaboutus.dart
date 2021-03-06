import 'package:flutter/material.dart';
import 'package:home_rental/component/appBarActionItems.dart';

import 'package:home_rental/component/header_about.dart';
import 'package:home_rental/component/siderespMenu.dart';
import 'package:home_rental/config/responsive.dart';
import 'package:home_rental/config/size_config.dart';
import 'package:home_rental/responsable/about/oneelementAbout.dart';
import 'package:home_rental/style/colors.dart';

class Dashaboutus extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SiderespMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: AppColors.black)),
              actions: [
                AppBarActionItems(),
              ],
            )
          : PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SiderespMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderAbout(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              oneelementAbout(),
                              SizedBox(height: 60),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
