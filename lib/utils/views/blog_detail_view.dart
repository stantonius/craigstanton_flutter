import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:CraigStantonWeb/utils/ResponsiveLayout.dart';

class BlogDetail extends StatelessWidget {
  final Map data;

  const BlogDetail({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Padding(
      padding: ResponsiveLayout.isSmallScreen(context)
          ? const EdgeInsets.fromLTRB(0, 20, 0, 0)
          : const EdgeInsets.fromLTRB(0, 120, 0, 0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data['title'],
                ),
              ],
            ),
            Expanded(
                child: Markdown(
              controller: controller,
              selectable: true,
              data: data['blogfile'],
              styleSheet: MarkdownStyleSheet(
                  blockquote: TextStyle(color: Colors.black),
                  code: TextStyle(color: Colors.black)),
            ))
          ],
        ),
      ),
    );
  }
}
