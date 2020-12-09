import 'package:flutter/material.dart';

/// I'm not actually sure if I needed to do this. It seems a bit overkill to
/// use a global key but I followed this tutorial that used this approach
/// https://www.filledstacks.com/post/template-layouts-and-navigation-in-flutter-web/
/// The code is here
/// https://github.com/FilledStacks/flutter-tutorials/tree/master/037-advanced-web-navigation/00-starting/lib

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  goBack() {
    return navigatorKey.currentState.pop();
  }
}
