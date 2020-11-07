import 'package:flutter/material.dart';

// Import main template and homepage class
import '../utils/templates/main_screen_template2.dart';
import '../utils/views/blog_admin_view.dart';

class BlogAdminScreen extends StatelessWidget {
  const BlogAdminScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(BlogAdmin());
  }
}
