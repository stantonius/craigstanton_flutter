import 'package:flutter/widgets.dart';
import './screen/homepage.dart';
import './screen/admin.dart';
import './screen/blog_home.dart';
import './screen/coming_soon.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  '/nothing': (BuildContext context) => Admin(),
  '/blog': (BuildContext context) => BlogHome(),
  '/about': (BuildContext context) => ComingSoon(),
  '/apps': (BuildContext context) => ComingSoon(),
};
