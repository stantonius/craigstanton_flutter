import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MainPageTemplate(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: ResponsiveLayout.isSmallScreen(context) ? 8 : 1,
              child: Card(
                elevation: 2,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [Text('Yo')],
                          ),
                          Row(
                            children: [Text('Pizza')],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ],
    )));
  }
}
