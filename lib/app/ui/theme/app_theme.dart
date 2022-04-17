import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blue,
  backgroundColor: Color(0xFF4248A5),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.montserrat(color: Colors.white),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Color(0xFF4248A5),
      elevation: 8,
    ),
  ),
);
