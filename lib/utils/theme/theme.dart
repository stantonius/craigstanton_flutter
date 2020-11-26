// Theme for entire app

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/**
 * TODO: ADD IN TEXT SIZE VARIATIONS FOR SMALL SCREENS
 * CURRENTLY THE TEXT SIZES ARE JUST FOR WEB
 * ie. font size 80 for headline 1 will never fit on a phone, so adjust 
 * as a fraction of this
 */

/// set the main colors here
const mainLightColour = Color(0xfff8f9fa);
const mainDarkColour = Color(0xff212529);

final appTheme = (bool isDarkTheme) => ThemeData(

    /// Color for appbar, toolbar, tabs
    primaryColor: Color(0xff212529),

    /// Main background for scaffold & majority of app
    scaffoldBackgroundColor: isDarkTheme ? mainDarkColour : mainLightColour,

    /// primaryTextTheme contrasts with the PRIMARY COLOUR
    primaryTextTheme: TextTheme(
        headline1:
            TextStyle(fontFamily: 'Oswald', fontSize: 36, color: Colors.white)),

    /// textTheme contrasts with the CARD and CANVAS/Scaffolding
    textTheme: TextTheme(
      headline1: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 80, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 80, color: mainDarkColour)),
      headline2: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 50, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 50, color: mainDarkColour)),
      headline3: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 40, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 40, color: mainDarkColour)),
      headline4: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 32, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 32, color: mainDarkColour)),

      /// Used for large text in dialogs (e.g., the month and year in the dialog
      /// shown by [showDatePicker]).
      headline5: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 25, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 25, color: mainDarkColour)),

      /// Used for the primary text in app bars and dialogs (e.g., [AppBar.title]
      /// and [AlertDialog.title]).
      headline6: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 18, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 18, color: mainDarkColour)),

      /// Used for the primary text in lists (e.g., [ListTile.title]).
      subtitle1: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: mainLightColour,
                  fontWeight: FontWeight.w300))
          : GoogleFonts.oswald(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: mainDarkColour,
                  fontWeight: FontWeight.w300)),

      /// For medium emphasis text that's a little smaller than [subtitle1].
      subtitle2: isDarkTheme
          ? GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 15, color: mainLightColour))
          : GoogleFonts.oswald(
              textStyle: TextStyle(fontSize: 15, color: mainDarkColour)),

      /// bodyText2 is the default text for entire application
      bodyText2: isDarkTheme
          ? GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: 15, color: mainLightColour))
          : TextStyle(
              fontFamily: 'Oswald', fontSize: 15, color: mainDarkColour),

      /// bodyText1 used for emphasis on what otherwise would be bodyText2
      bodyText1: isDarkTheme
          ? GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: mainLightColour,
                  fontWeight: FontWeight.bold))
          : GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: mainDarkColour,
                  fontWeight: FontWeight.bold)),

      /// Used for auxiliary text associated with images.
      caption: isDarkTheme
          ? GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: mainLightColour,
                  fontStyle: FontStyle.italic))
          : GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: mainDarkColour,
                  fontStyle: FontStyle.italic)),
/*
      button:,
      overline:
      */
    ),
    buttonTheme: ButtonThemeData(buttonColor: mainLightColour),
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    visualDensity: VisualDensity.adaptivePlatformDensity);
