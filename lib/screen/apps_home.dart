import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';

class AppsHome extends StatelessWidget {
  const AppsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(AppsCard(
      title: 'Basic Weather App',
      description:
          'Experiment to get familiar with Riverpod, including calling APIs in Flutter. As it turns out, it required even more engineering with Cloud Functions to bypass CORS restrictions on Google APIs.',
      url: '/weatherapp',
      img: "https://cdn.craigstanton.com/images/weather/sun_and_clouds.png",
    ));
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
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: ResponsiveLayout.isSmallScreen(context) ? 8 : 4,
              child: FractionallySizedBox(
                widthFactor:
                    ResponsiveLayout.isSmallScreen(context) ? 0.9 : 0.7,
                child: Card(
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
                            child: ListTile(
                              title: Text(title),
                              subtitle: Text(description),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ],
    );
  }
}
