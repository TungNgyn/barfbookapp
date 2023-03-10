import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  CustomTheme._();

  static final ThemeData classicLight = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xfffcfdf7),
    secondaryHeaderColor: Color(0xffe3f2fd),
    shadowColor: Color(0xff000000),
    splashColor: Color(0x66c8c8c8),
    splashFactory: InkSplash.splashFactory,
    textTheme: GoogleFonts.lexendTextTheme(),
  );

  static final ThemeData classicDark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xff1a1c19),
    secondaryHeaderColor: Color(0xff616161),
    shadowColor: Color(0xff000000),
    splashColor: Color(0x40cccccc),
    splashFactory: InkSplash.splashFactory,
    textTheme: GoogleFonts.lexendTextTheme(),
  );
}
