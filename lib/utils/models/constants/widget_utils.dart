import 'package:CraigStantonWeb/utils/services/locator/locator.dart';
import 'package:CraigStantonWeb/utils/services/locator/navigation.dart';

import '../../layouts/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  Widget spaceHorizontal(double width) {
    return SizedBox(
      width: width,
    );
  }

  Widget spaceVertical(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget circalContainer(Color color, double size) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(390)),
            color: color));
  }

  Widget menuButtons(
      String buttontext, String namedlink, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        child: FlatButton(
            onPressed: () {
              //Navigator.pushNamed(context, namedlink);
              locator<NavigationService>().navigateTo(namedlink);
              //locator<NavigationService>().navigatorKey.currentState.
              Scaffold.of(context).openEndDrawer();
            },
            child: Text(
              buttontext,
              style: Theme.of(context).textTheme.headline5,
            )));
  }

  Widget menuText(String name, Color color, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        name,
        style: TextStyle(
          color: color,
          fontSize: ResponsiveLayout.isSmallScreen(context) ? 18 : 20,
          //fontFamily: ConstUtils().stringUtils.fontMenu
        ),
      ),
    );
  }

  Widget menuTextWithSize(
      {BuildContext context,
      String name,
      Color color,
      double textSizeSmall,
      double textSizeMedium,
      double textSizeLarge}) {
    double textSize = 10;
    if (ResponsiveLayout.isSmallScreen(context)) {
      textSize = textSizeSmall;
    } else if (ResponsiveLayout.isMediumScreen(context)) {
      textSize = textSizeMedium;
    } else {
      textSize = textSizeLarge;
    }

    return Text(name,
        style:
            Theme.of(context).textTheme.headline4.copyWith(fontSize: textSize));
  }

  Widget menuTextWithCenterSize(
      {BuildContext context,
      String name,
      Color color,
      double textSizeSmall,
      double textSizeMedium,
      double textSizeLarge}) {
    double textSize = 10;
    if (ResponsiveLayout.isSmallScreen(context)) {
      textSize = textSizeSmall;
    } else if (ResponsiveLayout.isMediumScreen(context)) {
      textSize = textSizeMedium;
    } else {
      textSize = textSizeLarge;
    }

    return Text(
      name,
      textAlign: ResponsiveLayout.isSmallScreen(context)
          ? TextAlign.center
          : TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        //fontFamily: ConstUtils().stringUtils.fontMenu
      ),
    );
  }

  Widget headingText(
      {BuildContext context,
      String name,
      Color color,
      double textSizeSmall,
      double textSizeMedium,
      double textSizeLarge}) {
    double textSize = 10;
    if (ResponsiveLayout.isSmallScreen(context)) {
      textSize = textSizeSmall;
    } else if (ResponsiveLayout.isMediumScreen(context)) {
      textSize = textSizeMedium;
    } else {
      textSize = textSizeLarge;
    }

    return Text(name,
        style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: textSize,
              fontWeight: FontWeight.w700,
            ));
  }

  Widget contentText(
      {BuildContext context, String name, Color color, double fontSize}) {
    return Text(
      name,
      style: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(color: Color(0xff6c757d), fontWeight: FontWeight.w700),
    );
  }

  Widget contentCenterText(
      {BuildContext context,
      String name,
      Color color,
      double textSizeSmall,
      double textSizeMedium,
      double textSizeLarge}) {
    double textSize = 10;
    if (ResponsiveLayout.isSmallScreen(context)) {
      textSize = textSizeSmall;
    } else if (ResponsiveLayout.isMediumScreen(context)) {
      textSize = textSizeMedium;
    } else {
      textSize = textSizeLarge;
    }

    return Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: FontWeight.w700,
        //fontFamily: ConstUtils().stringUtils.fontContent
      ),
    );
  }

  Widget headingCenterText(String name, Color color, double fontSize) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        //fontFamily: ConstUtils().stringUtils.fontHeading
      ),
    );
  }

  Widget button(String buttonName, BuildContext context) {
    return OutlineButton(
      color: Colors.red,
      onPressed: () => {print('Pressed')},
      child: Text(buttonName),
    );
  }

  Widget lineHorizontal({double height, Color color}) {
    return Container(
      height: height,
      color: color,
    );
  }

  Widget lineVertical({double height, Color color, double width}) {
    return Container(
      height: height,
      color: color,
      width: width,
    );
  }

  Widget centreTextPlaceholder(String message) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        )
      ],
    ));
  }
}
