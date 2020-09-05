import 'package:flutter/material.dart';

// Import main template and homepage class
import '../main_screen_template2.dart';
import '../utils/views/about_view.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(AboutView());
  }
}
