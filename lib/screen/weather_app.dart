import 'dart:convert';
import 'dart:html';

import 'package:CraigStantonWeb/utils/generated_files/env.dart';
import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

/// Main Weather App

class WeatherApp extends HookWidget {
  const WeatherApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currentSelection = useProvider(placeSelected.state);

    return Container(
        child: FractionallySizedBox(
            widthFactor: ResponsiveLayout.isSmallScreen(context) ? 0.9 : 0.4,
            // needs to be a ratio (between 0 and 1) hence divide by screenHeight again
            heightFactor: ResponsiveLayout.isSmallScreen(context)
                ? (screenHeight * 0.9) / screenHeight
                : (screenHeight * 0.65) / screenHeight,
            child: Card(
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [PlaceSearch()],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              currentSelection.isNotEmpty
                                  ? Text(currentSelection.last.description)
                                  : Text("")
                            ],
                          ),
                        ),
                        Row(children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.network(currentSelection.isEmpty
                                ? 'https://cdn.craigstanton.com/images/weather/sun.png'
                                : getWeatherIcon(currentSelection
                                    .last.weather['weather_code']['value'])),
                          )
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              currentSelection.isNotEmpty
                                  ? Column(
                                      children: [
                                        Text(
                                          currentSelection
                                                  .last.weather['temp']['value']
                                                  .toString() +
                                              " \u2103",
                                          style: TextStyle(fontSize: 28),
                                        ),
                                        Text(new ReCase(currentSelection.last
                                                    .weather['weather_code']
                                                ['value'])
                                            .titleCase),
                                        Row(children: [
                                          Text('Feels like '),
                                          Text(currentSelection
                                                  .last
                                                  .weather['feels_like']
                                                      ['value']
                                                  .toString() +
                                              " \u2103"),
                                        ])
                                      ],
                                    )
                                  : Text(" \u2103")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}

// Classes for riverpod

class PlaceSuggestion {
  final String description;
  final String placeId;
  final bool selected;

  PlaceSuggestion({this.description, this.placeId, this.selected});

  @override
  String toString() {
    return 'The place is $description with id $placeId';
  }
}

class LocationWeather {
  final String description;
  final String placeId;
  final weather;
  final coords;

  LocationWeather({
    this.description,
    this.placeId,
    this.weather,
    this.coords,
  });

  @override
  String toString() {
    return 'LocationWeather(description: $description, placeId: $placeId, weather: $weather, coords: $coords)';
  }

  LocationWeather copyWith({
    String description,
    String placeId,
    weather,
    coords,
  }) {
    return LocationWeather(
      description: description ?? this.description,
      placeId: placeId ?? this.placeId,
      weather: weather ?? this.weather,
      coords: coords ?? this.coords,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'placeId': placeId,
      'weather': weather,
      'coords': coords,
    };
  }

  factory LocationWeather.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LocationWeather(
      description: map['description'],
      placeId: map['placeId'],
      weather: Map.from(map['weather']),
      coords: Map.from(map['coords']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationWeather.fromJson(String source) =>
      LocationWeather.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return o is LocationWeather &&
        o.description == description &&
        o.placeId == placeId &&
        mapEquals(o.weather, weather) &&
        mapEquals(o.coords, coords);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        placeId.hashCode ^
        weather.hashCode ^
        coords.hashCode;
  }
}

/// Riverpod state management

class SuggestionsList extends StateNotifier<List<PlaceSuggestion>> {
  /// Empty initial state, unless we want to use the current location to
  /// fulfill, but this seems much
  SuggestionsList() : super([]);

  void addItems(List locGuesses) {
    state = [
      for (final loc in locGuesses)
        PlaceSuggestion(
            description: loc['description'],
            placeId: loc['placeId'],
            selected: false)
    ];
  }

  void clear() {
    state = [];
  }
}

// Class keeps a record of all searches, hence a list
class LocationWeatherState extends StateNotifier<List<LocationWeather>> {
  LocationWeatherState() : super([]);

  Future<Map> fetchCoords(String placeId) async {
    final details = await http.get(
        'https://europe-west2-craigstanton-3b97f.cloudfunctions.net/placeDetails',
        //'http://localhost:5001/craigstanton-3b97f/europe-west2/placeAutocomplete',
        headers: {"placeid": placeId});
    return json.decode(details.body);
  }

  Future<Map> fetchWeather(Map coords) async {
    const api_key = Env.climacell_api;
    final weather = await http.get(
      'https://api.climacell.co/v3/weather/realtime?lat=${coords['lat']}&lon=${coords['lng']}&unit_system=si&fields=precipitation%2Ctemp%2Cfeels_like%2Cweather_code&apikey=$api_key',
    );
    return json.decode(weather.body);
  }

  void addLocation(locSelected) async {
    final coords = await fetchCoords(locSelected['placeId']);
    final weather = await fetchWeather(coords);
    state = [
      ...state,
      LocationWeather(
        description: locSelected['description'],
        placeId: locSelected['placeId'],
        coords: coords,
        weather: weather,
      )
    ];
    print('Updated STATE is ${state.last}');
  }
}

/// Setting initial states with Riverpod

final placesState = StateNotifierProvider<SuggestionsList>((ref) {
  return SuggestionsList();
});

final placeSelected = StateNotifierProvider<LocationWeatherState>((ref) {
  return LocationWeatherState();
});

/// Place search

class PlaceSearch extends StatefulHookWidget {
  @override
  _PlaceSearchState createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  final _controller = TextEditingController();

  Future autoCompleteSearch(String value) async {
    final preds = await http.get(
        'https://europe-west2-craigstanton-3b97f.cloudfunctions.net/placeAutocomplete',
        //'http://localhost:5001/craigstanton-3b97f/europe-west2/placeAutocomplete',
        headers: {"text": value});
    print('These are the predictions returned: ${json.decode(preds.body)}');
    return json.decode(preds.body);
  }

  @override
  Widget build(BuildContext context) {
    // Always initialise state read within build widget
    final currentPreds = useProvider(placesState.state);

    return Container(
      child: SizedBox(
        width: ResponsiveLayout.isSmallScreen(context)
            ? MediaQuery.of(context).size.width * 0.7
            : MediaQuery.of(context).size.width * 0.3,
        child: Stack(children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          ResponsiveLayout.isSmallScreen(context) ? 10 : 100),
                  child: TextField(
                    //style: TextStyle(color: Colors.black),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a location',
                      //hintStyle: TextStyle(color: Colors.black)
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        autoCompleteSearch(value).then(
                            (val) => context.read(placesState).addItems(val));
                        setState(() {});
                      }
                    },
                  ))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: currentPreds.length > 0
                      ? ListView.builder(
                          itemCount: currentPreds.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: mediumCanvasColour,
                              hoverColor: Colors.deepPurple[200],
                              selectedTileColor: Colors.deepPurple[300],
                              onTap: () {
                                /// onTap does 3 things:
                                /// 1) sets the value of controller text to the value selected
                                _controller.text =
                                    currentPreds[index].description;

                                /// 2) create new LocationWeather object using coords received
                                context.read(placeSelected).addLocation({
                                  "description":
                                      currentPreds[index].description,
                                  "placeId": currentPreds[index].placeId,
                                });

                                /// 3) clear suggestions list to get rid of dropdown
                                context.read(placesState).clear();
                              },
                              //tileColor: Colors.white,
                              title: Text(
                                currentPreds[index].description,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        )
                      : null)),
        ]),
      ),
    );
  }
}

String getWeatherIcon(code) {
  switch (code) {
    case "rain":
    case "rain_heavy":
    case "rain_light":
    case "freezing_rain":
    case "freezing_rain_heavy":
    case "freezing_rain_light":
    case "freezing_drizzle":
      return 'https://cdn.craigstanton.com/images/weather/rain.png';
    case "drizzle":
      return 'https://cdn.craigstanton.com/images/weather/cloudy_rain.png';
    case "cloudy":
    case "mostly_cloudy":
      return 'https://cdn.craigstanton.com/images/weather/cloud.png';
    case "snow":
    case "snow_heavy":
    case "snow_light":
      return 'https://cdn.craigstanton.com/images/weather/snow.png';
    case "flurries":
      return 'https://cdn.craigstanton.com/images/weather/cloudy_snow.png';
    case "tstorm":
      return 'https://cdn.craigstanton.com/images/weather/thunderstorm.png';
    case "partly_cloudy":
    case "mostly_clear":
      return 'https://cdn.craigstanton.com/images/weather/sun_and_clouds.png';
    case "clear":
      return 'https://cdn.craigstanton.com/images/weather/sun.png';
    default:
      print("WENT TO DEFAULT");
      return 'https://cdn.craigstanton.com/images/weather/sun.png';
  }
}
