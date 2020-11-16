import 'dart:html';

import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

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

/// Riverpod state management

class WeatherStateNotifier extends StateNotifier {
  WeatherStateNotifier(state) : super(state);
}

final placesState = StateNotifierProvider((ref) {});

/// Place search

class PlaceSearch extends StatefulWidget {
  @override
  _PlaceSearchState createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  final _controller = TextEditingController();
  GooglePlace googlePlace;
  String predictions;

  @override
  void initState() {
    //DotEnv().load('../../.env');
    //String apiKey = DotEnv().env['GOOGLE_PLACES_API'];
    var apiKey = 'AIzaSyB_YlkjcBnFchQ6LCptrXPS2YVVcMVdKuA';
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  void autoCompleteSearch(String value) async {
    final resp = await http.get(
        'https://us-central1-craigstanton-3b97f.cloudfunctions.net/placeAutocomplete',
        headers: {"text": value});
    setState(() {
      predictions = resp.body;
      print(resp.body);
    });

    /*
    final result = await googlePlace.autocomplete.get(value);
    print('API RESULT: ${result?.predictions}');
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
        print(predictions);
      })*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 400,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Enter a location'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = '';
                      });
                    }
                  }
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Hello'))),
        ]),
      ),
    );
  }
}
