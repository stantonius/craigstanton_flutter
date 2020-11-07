import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:markdown_widget/config/highlight_themes.dart' as theme;
import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';

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
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data['title'],
                  ),
                ],
              ),
            ),
            Expanded(
                child: MarkdownWidget(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              //controller: controller,
              data: data['blogfile'],
              styleConfig: StyleConfig(
                  markdownTheme: MarkdownTheme.lightTheme,
                  preConfig: PreConfig(
                      autoDetectionLanguage: true,
                      theme: theme.githubGistTheme)),
            ))
          ],
        ),
      ),
    );
  }
}
