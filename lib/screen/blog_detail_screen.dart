import 'package:flutter/material.dart';

// Import main template and homepage class
import '../main_screen_template2.dart';
import '../utils/views/blog_detail_view.dart';

class BlogDetailHome extends StatelessWidget {
  final Map data;
  const BlogDetailHome({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(BlogDetail(data: data));
  }
}
