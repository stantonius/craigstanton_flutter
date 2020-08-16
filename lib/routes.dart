import 'package:CraigStantonWeb/screen/blog.dart';
import 'package:flutter/widgets.dart';
import './screen/homepage.dart';
import './screen/admin.dart';
import './screen/blog.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  '/nothing': (BuildContext context) => Admin(),
  '/blog': (BuildContext context) => BlogPage()
};