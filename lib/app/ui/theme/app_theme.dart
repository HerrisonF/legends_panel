import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Color(0xff9B7628),
  backgroundColor: Colors.blueGrey[900],
  accentColor: Colors.white70,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.montserrat(
      color: Colors.white,
    ),
    fillColor: Colors.white,
    filled: true,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Color(0xff9B7628),
    ),
  )
);
