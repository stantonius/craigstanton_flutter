import 'dart:html';

import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MainPageTemplate(Container(
        child: FractionallySizedBox(
            widthFactor: ResponsiveLayout.isSmallScreen(context) ? 0.9 : 0.4,
            // needs to be a ratio (between 0 and 1) hence divide by screenHeight again
            heightFactor: (screenHeight * 0.65) / screenHeight,
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
                          children: [PlaceSearch()],
                        ),
                        Row(
                          children: [Text('Place')],
                        ),
                        Row(children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.network(
                              'https://cdn.craigstanton.com/images/weather/sun.png',
                            ),
                          )
                        ]),
                        Row(
                          children: [Text('Temp')],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }
}

class PlaceSearch extends StatefulWidget {
  @override
  _PlaceSearchState createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Enter a search term'),
      ),
    );
  }
}
