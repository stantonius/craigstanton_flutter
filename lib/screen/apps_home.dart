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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FractionallySizedBox(
                widthFactor:
                    ResponsiveLayout.isSmallScreen(context) ? 0.9 : 0.7,
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
                          child: Image.network(
                            img ??
                                'https://cdn.craigstanton.com/images/placeholder.png',
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      title,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      description,
                                    )
                                  ],
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
            ),
          ],
        ),
      ],
    );
  }
}
