import 'package:CraigStantonWeb/main.dart';
import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/widgets/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:markdown_widget/config/widget_config.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:markdown_widget/config/highlight_themes.dart' as theme;

// Import main template and homepage class
import '../utils/templates/main_screen_template.dart';

class BlogDetailHome extends StatelessWidget {
  final Map data;
  const BlogDetailHome({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(BlogDetail(data: data));
  }
}

class BlogDetail extends HookWidget {
  final Map data;

  const BlogDetail({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TocController();
    final isDarkTheme = useProvider(appThemeProvider).state;

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
                    widgetConfig: WidgetConfig(ul: _ulFunction()),
                    loadingWidget: CircularProgressIndicator(),
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal:
                            ResponsiveLayout.isSmallORMediumScreen(context)
                                ? 40
                                : 250),
                    controller: controller,
                    data: data['blogfile'],
                    styleConfig: StyleConfig(
                      ulConfig: UlConfig(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(height: 1.5),
                        dotSize: 5,
                      ),
                      titleConfig: TitleConfig(
                          commonStyle: TextStyle(
                              height: 3,
                              color:
                                  Theme.of(context).textTheme.headline1.color),
                          space: 10),
                      pConfig: PConfig(
                          linkStyle:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                          onLinkTap: (url) => launchUrl(url),
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(height: 1.5)),
                      codeConfig: CodeConfig(
                        codeStyle: GoogleFonts.sourceCodePro(
                            color: Colors.red,
                            fontSize:
                                Theme.of(context).textTheme.bodyText2.fontSize),
                      ),
                      blockQuoteConfig: BlockQuoteConfig(
                          backgroundColor: Colors.pink,
                          blockColor: Colors.pink,
                          blockStyle: TextStyle(color: Colors.pink)),
                      preConfig: PreConfig(
                          language: "dart",
                          theme: theme.a11yLightTheme,
                          textStyle: GoogleFonts.sourceCodePro(fontSize: 12)),
                    )))
          ],
        ),
      ),
    );
  }
}

_ulFunction() {
  print('DOES THIS WORK');
}
