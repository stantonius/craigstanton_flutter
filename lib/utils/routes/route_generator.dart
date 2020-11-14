import 'package:CraigStantonWeb/screen/apps_home.dart';
import 'package:flutter/material.dart';
import '../../screen/homepage.dart';
import '../../screen/blog_admin_screen.dart';
//import '../../screen/coming_soon.dart';
import '../../screen/blog_home.dart';
import '../../screen/blog_detail_screen.dart';
import '../../screen/about_screen.dart';
import '../../screen/weather_app.dart';

/// Some notes on this approach:
/// Tutorial from ResoCoder is here:
/// https://resocoder.com/2019/04/27/flutter-routes-navigation-parameters-named-routes-ongenerateroute/
/// However there is another package that could be useful in the future and that is called Fluro
/// This great tutorial speaks to it:
/// https://edsonbueno.com/2020/02/26/spotless-routing-and-navigation-in-flutter/

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case ('/'):
        return MaterialPageRoute(
            builder: (_) => HomePage(),
            settings: RouteSettings(name: settings.name));
      case ('/nothing'):
        return MaterialPageRoute(
            builder: (_) => BlogAdminScreen(),
            settings: RouteSettings(name: settings.name));
      case ('/blog'):
        return MaterialPageRoute(
            builder: (_) => BlogHomeScreen(),
            settings: RouteSettings(name: settings.name));
      case ('/blogdetail'):
        return MaterialPageRoute(
            builder: (_) => BlogDetailHome(data: args),
            settings: RouteSettings(name: settings.name));
      case ('/about'):
        return MaterialPageRoute(
            builder: (_) => AboutScreen(),
            settings: RouteSettings(name: settings.name));
      case ('/apps'):
        return MaterialPageRoute(
            builder: (_) => AppsHome(),
            settings: RouteSettings(name: settings.name));
      case ('/weatherapp'):
        return MaterialPageRoute(
          builder: (_) => WeatherApp(),
          settings: RouteSettings(name: settings.name),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}