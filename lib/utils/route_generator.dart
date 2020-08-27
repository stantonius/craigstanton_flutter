import 'package:flutter/material.dart';
import '../screen/homepage.dart';
import '../screen/admin.dart';
import '../screen/blog_home.dart';
import '../screen/coming_soon.dart';
import '../screen/blog_details.dart';

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
            builder: (_) => Admin(),
            settings: RouteSettings(name: settings.name));
      case ('/blog'):
        return MaterialPageRoute(
            builder: (_) => BlogHome(),
            settings: RouteSettings(name: settings.name));
      case ('/blogdetail'):
        return MaterialPageRoute(
            builder: (_) => BlogDetail(data: args),
            settings: RouteSettings(name: settings.name));
      case ('/about'):
        return MaterialPageRoute(
            builder: (_) => ComingSoon(),
            settings: RouteSettings(name: settings.name));
      case ('/apps'):
        return MaterialPageRoute(
            builder: (_) => ComingSoon(),
            settings: RouteSettings(name: settings.name));
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
