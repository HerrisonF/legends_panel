import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: Colors.blue,
    backgroundColor: Colors.blueGrey[900],
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.montserrat(
        color: Colors.white,
      ),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.brown[700],
      ),
    ));
