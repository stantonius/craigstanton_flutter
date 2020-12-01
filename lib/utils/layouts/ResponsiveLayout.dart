import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;
  final Widget xLargeScreen;

  const ResponsiveLayout(
      {Key key,
      @required this.largeScreen,
      this.mediumScreen,
      this.smallScreen,
      this.xLargeScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isSmallORMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 1080;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  static bool isXLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1500;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return largeScreen;
        } else if (constraints.maxWidth < 1200 && constraints.maxWidth > 800) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
