import 'package:flutter/widgets.dart';
import './screen/homepage.dart';
import './screen/admin.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  '/nothing': (BuildContext context) => Admin()
};