import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApodTheme {
  //custom text style

  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    subtitle1: GoogleFonts.openSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    subtitle2: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.openSans(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    subtitle1: GoogleFonts.openSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    subtitle2: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.purple,
        secondary: Colors.purpleAccent,
        brightness: Brightness.light,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }

  static dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.purple,
        secondary: Colors.purpleAccent,
        brightness: Brightness.dark,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
