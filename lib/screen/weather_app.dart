import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/templates/main_screen_template.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MainPageTemplate(
      Container(
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
      )),
    );
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
    return Container(
        child: FractionallySizedBox(
      widthFactor: 0.5,
      child: TextField(
        controller: _controller,
        onTap: () async {},
        decoration: InputDecoration(
          icon: Container(
              margin: EdgeInsets.only(left: 20),
              width: 10,
              height: 10,
              child: Icon(Icons.home, color: Colors.black)),
          hintText: "Enter your shipping address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
        ),
      ),
    ));
  }
}
