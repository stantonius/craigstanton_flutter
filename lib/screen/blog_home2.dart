import 'package:flutter/material.dart';

// Import main template and homepage class
import '../utils/templates/main_screen_template2.dart';
import '../utils/views/blog_home_view.dart';

class BlogHome2 extends StatelessWidget {
  const BlogHome2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(BlogHome());
  }
}
