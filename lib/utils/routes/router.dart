import 'package:CraigStantonWeb/screen/about_screen.dart';
import 'package:CraigStantonWeb/screen/apps_home.dart';
import 'package:CraigStantonWeb/screen/blog_admin_screen.dart';
import 'package:CraigStantonWeb/screen/blog_detail_screen.dart';
import 'package:CraigStantonWeb/screen/blog_home.dart';
import 'package:CraigStantonWeb/screen/homepage.dart';
import 'package:CraigStantonWeb/screen/weather_app.dart';
import 'package:CraigStantonWeb/utils/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Getting arguments passed in while calling Navigator.pushNamed
  final args = settings.arguments;

  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomePage(), settings);
    case AboutRoute:
      return _getPageRoute(AboutScreen(), settings);
    case BlogRoute:
      return _getPageRoute(BlogHomeScreen(), settings);
    case BlogDetailRoute:

      /// I have read that I shouldn't be passing complex data through, but rather
      /// an ID and then fetch the blog values based on that ID. However this makes
      /// double the calls to Firestore so for now I am leaving this as is.
      return _getPageRoute(BlogDetailHome(data: args), settings);
    case BlogAdminRoute:
      return _getPageRoute(BlogAdminScreen(), settings);
    case AppsRoute:
      return _getPageRoute(AppsHome(), settings);
    case WeatherAppRoute:
      return _getPageRoute(WeatherApp(), settings);

    default:
      _getPageRoute(HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              child,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
