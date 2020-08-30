import 'package:flutter/material.dart';

// Import main template and homepage class
import '../main_screen_template2.dart';
import '../utils/views/home_view.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(PageHome());
  }
}
