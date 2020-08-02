// Theme for entire app

import 'package:flutter/material.dart';

final appTheme = () => ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontFamily: 'Oswald', fontSize: 24, color: Colors.white),
          // bodyText2 is the default text for entire application
          bodyText2: TextStyle(
              fontFamily: 'Oswald', fontSize: 18, color: Colors.white),
          headline2: TextStyle(
              fontFamily: 'Special Elite',
              fontSize: 28.0,
              color: Colors.white)),
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity);