// Refactoring old code and moving the black circles to a separate widget
// Allows to add/remove easily

import 'package:flutter/material.dart';
import '../layouts/ResponsiveLayout.dart';
import '../models/const_utils.dart';

class BackgroundCircles extends StatelessWidget {
  const BackgroundCircles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Center(
        child: ConstUtils().widgetUtils.circalContainer(
            ConstUtils().colorUtils.blackBG_B,
            ResponsiveLayout.isSmallScreen(context) ? 300 : 600),
      ),
      Center(
        child: ConstUtils().widgetUtils.circalContainer(
            ConstUtils().colorUtils.blackBG_C,
            ResponsiveLayout.isSmallScreen(context) ? 250 : 500),
      ),
      Center(
        child: ConstUtils().widgetUtils.circalContainer(
            ConstUtils().colorUtils.blackBG_D,
            ResponsiveLayout.isSmallScreen(context) ? 200 : 400),
      ),
      Align(
        alignment: ResponsiveLayout.isSmallScreen(context)
            ? Alignment.topCenter
            : Alignment.topRight,
        child: Container(
            margin: EdgeInsets.only(
                top: 60,
                right: ResponsiveLayout.isSmallScreen(context) ? 0 : 100),
            height: ResponsiveLayout.isSmallScreen(context) ? 200 : 400,
            width: ResponsiveLayout.isSmallScreen(context) ? 200 : 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(390)),
                color: ConstUtils().colorUtils.blackCircal)),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: EdgeInsets.all(
                ResponsiveLayout.isSmallScreen(context) ? 80 : 140),
            transform: Matrix4.translationValues(
                ResponsiveLayout.isSmallScreen(context) ? -60.0 : -100.0,
                ResponsiveLayout.isSmallScreen(context) ? -60.0 : -100.0,
                0.0),
            child: Image.asset(
              ConstUtils().stringUtils.imgIcon,
              width: ResponsiveLayout.isSmallScreen(context) ? 0 : 40,
              height: ResponsiveLayout.isSmallScreen(context) ? 0 : 40,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(390)),
                color: ConstUtils().colorUtils.blackCircal)),
      ),
    ]);
  }
}
