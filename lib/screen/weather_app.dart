import 'dart:convert';

import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';
import '../utils/models/secrets.dart';
import 'package:http/http.dart';

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
                          children: [PlacesSearch()],
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

class PlacesSearch extends StatefulWidget {
  PlacesSearch({Key key}) : super(key: key);

  @override
  _PlacesSearchState createState() => _PlacesSearchState();
}

class _PlacesSearchState extends State<PlacesSearch> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: _controller,
        onTap: () async {
          showSearch(context: context, delegate: );
        },
        decoration: InputDecoration(
          icon: Container(
              margin: EdgeInsets.only(left: 20),
              width: 10,
              height: 10,
              child: Icon(Icons.place, color: Colors.black)),
          hintText: "Enter your shipping address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
        ),
      ),
    );
  }
}

class Place extends SearchDelegate<Suggestion> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(tooltip: 'Clear', icon: Icon(Icons.clear), onPressed: () {
      query = '';
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(tooltip: 'Back', icon: Icon(Icons.arrow_back), onPressed: () {
      close(context, null);
    },);
  }

  @override 
  Widget buildResults(BuildContext context) {return null;}

  @override 
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title:
                        Text(snapshot.data[index]),
                    onTap: () {
                      close(context, snapshot.data[index]);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider({this.sessionToken, this.key});

  final sessionToken;
  final String key;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    // if you want to get the details of the selected place by place_id
  }
}

}