import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  primaryColor: Colors.deepPurple,
  primaryColorDark: Colors.deepPurple,
  textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 18),
      bodyText2: TextStyle(fontSize: 16),
      button: TextStyle(
        fontWeight: FontWeight.bold,
      )),
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurple,
  ),
);
