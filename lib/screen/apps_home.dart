import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';

class AppsHome extends StatelessWidget {
  const AppsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(AppsCard(
        title: 'Title', description: 'Description', url: '/weatherapp'));
  }
}

class AppsCard extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final String url;

  const AppsCard(
      {@required this.title,
      @required this.description,
      @required this.url,
      this.img});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: ResponsiveLayout.isSmallScreen(context) ? 8 : 4,
              child: Card(
                elevation: 2,
                color: Colors.grey[200],
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(url);
                  },
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text('Image Placeholder'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [Text(title)],
                              ),
                              Row(
                                children: [Text(description)],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}
