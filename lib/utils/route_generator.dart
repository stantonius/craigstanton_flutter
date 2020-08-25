import 'package:flutter/material.dart';
import '../screen/homepage.dart';
import '../screen/admin.dart';
import '../screen/blog.dart';
import '../screen/coming_soon.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case ('/'):
          return MaterialPageRoute(builder: (_) => HomePage(), settings: RouteSettings(name: settings.name));
      case ('/nothing'):
          return MaterialPageRoute(builder: (_) => Admin(), settings: RouteSettings(name: settings.name));
      case ('/blog'):
          return MaterialPageRoute(builder: (_) => BlogPage(), settings: RouteSettings(name: settings.name));
      case ('/about'):
          return MaterialPageRoute(builder: (_) => ComingSoon(), settings: RouteSettings(name: settings.name));
      case ('/apps'):
          return MaterialPageRoute(builder: (_) => ComingSoon(), settings: RouteSettings(name: settings.name));
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