import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  CustomTheme._();

  static final ThemeData classicLight = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xfffcfdf7),
    secondaryHeaderColor: Color(0xffe3f2fd),
    shadowColor: Color(0xff000000),
    splashColor: Color(0x66c8c8c8),
    splashFactory: InkSplash.splashFactory,
    textTheme: TextTheme(
        bodyLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xdd000000))),
        bodyMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xdd000000))),
        bodySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0x8a000000))),
        displayLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0x8a000000))),
        displayMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0x8a000000))),
        displaySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0x8a000000))),
        headlineLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0x8a000000))),
        headlineMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0x8a000000))),
        headlineSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xdd000000))),
        labelLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xdd000000))),
        labelMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xff000000))),
        labelSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xff000000))),
        titleLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xdd000000))),
        titleMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xdd000000))),
        titleSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xff000000)))),
    typography: Typography(
      black: TextTheme(
          bodyLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          bodyMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          bodySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          displayLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          displayMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          displaySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          headlineLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          headlineMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          headlineSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          labelLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000))),
          labelMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000))),
          labelSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000))),
          titleLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          titleMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          titleSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000)))),
      white: TextTheme(
          bodyLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          bodyMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          bodySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          displayLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          displayMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          displaySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          headlineLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          headlineMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          headlineSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          labelLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          labelMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          labelSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          titleLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          titleMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          titleSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff)))),
    ),
    applyElevationOverlayColor: false,
    canvasColor: Color(0xfffcfdf7),
    cardColor: Color(0xfffcfdf7),
    dialogBackgroundColor: Color(0xfffcfdf7),
    disabledColor: Color(0x61000000),
    dividerColor: Color(0x1f1a1c19),
    focusColor: Color(0x1f000000),
    highlightColor: Color(0x66bcbcbc),
    hintColor: Color(0x99000000),
    hoverColor: Color(0x0a000000),
    indicatorColor: Color(0xffffffff),
    inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        filled: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        isCollapsed: false,
        isDense: false),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    primaryColor: Color(0xff1f6c2f),
    primaryColorDark: Color(0xff1976d2),
    primaryColorLight: Color(0xffbbdefb),
    unselectedWidgetColor: Color(0x8a000000),
    visualDensity: VisualDensity.compact,
    colorScheme: ColorScheme(
        background: Color(0xfffcfdf7),
        brightness: Brightness.light,
        error: Color(0xffba1a1a),
        errorContainer: Color(0xffffdad6),
        inversePrimary: Color(0xff8bd88e),
        inverseSurface: Color(0xff2f312d),
        onBackground: Color(0xff1a1c19),
        onError: Color(0xffffffff),
        onErrorContainer: Color(0xff410002),
        onInverseSurface: Color(0xfff0f1eb),
        onPrimary: Color(0xffffffff),
        onPrimaryContainer: Color(0xff002107),
        onSecondary: Color(0xffffffff),
        onSecondaryContainer: Color(0xff101f10),
        onSurface: Color(0xff1a1c19),
        onSurfaceVariant: Color(0xff424940),
        onTertiary: Color(0xffffffff),
        onTertiaryContainer: Color(0xff001f23),
        outline: Color(0xff72796f),
        outlineVariant: Color(0xffc2c9bd),
        primary: Color(0xff1f6c2f),
        primaryContainer: Color(0xffb3f2b2),
        secondary: Color(0xff526350),
        secondaryContainer: Color(0xffd4e8d0),
        shadow: Color(0xff000000),
        surface: Color(0xfffcfdf7),
        surfaceTint: Color(0xff1f6c2f),
        surfaceVariant: Color(0xffdee5d9),
        tertiary: Color(0xff39656c),
        tertiaryContainer: Color(0xffbcebf2)),
    primaryTextTheme: TextTheme(
        bodyLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        bodyMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        bodySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displayLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displayMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displaySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff)))),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      height: 36,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      minWidth: 88,
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignedDropdown: false,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff1f6c2f),
        primaryContainer: Color(0xffb3f2b2),
        onPrimary: Color(0xffffffff),
        onPrimaryContainer: Color(0xff002107),
        secondary: Color(0xff526350),
        secondaryContainer: Color(0xffd4e8d0),
        onSecondaryContainer: Color(0xff101f10),
        onSecondary: Color(0xffffffff),
        error: Color(0xffba1a1a),
        errorContainer: Color(0xffffdad6),
        onError: Color(0xffffffff),
        inversePrimary: Color(0xff8bd88e),
        inverseSurface: Color(0xff2f312d),
        onErrorContainer: Color(0xff410002),
        onInverseSurface: Color(0xfff0f1eb),
        background: Color(0xfffcfdf7),
        onBackground: Color(0xff1a1c19),
        shadow: Color(0xff000000),
        surface: Color(0xfffcfdf7),
        surfaceTint: Color(0xff1f6c2f),
        surfaceVariant: Color(0xffdee5d9),
        tertiary: Color(0xff39656c),
        tertiaryContainer: Color(0xffbcebf2),
        onSurface: Color(0xff1a1c19),
        onSurfaceVariant: Color(0xff424940),
        onTertiary: Color(0xffffffff),
        onTertiaryContainer: Color(0xff001f23),
        outline: Color(0xff72796f),
        outlineVariant: Color(0xffc2c9bd),
      ),
    ),
  );

  static final ThemeData classicDark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xff1a1c19),
    secondaryHeaderColor: Color(0xff616161),
    shadowColor: Color(0xff000000),
    splashColor: Color(0x66c8c8c8),
    splashFactory: InkSplash.splashFactory,
    textTheme: TextTheme(
        bodyLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        bodyMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        bodySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displayLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displayMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displaySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff)))),
    typography: Typography(
      black: TextTheme(
          bodyLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          bodyMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          bodySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          displayLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          displayMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          displaySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          headlineLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          headlineMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0x8a000000))),
          headlineSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          labelLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000))),
          labelMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000))),
          labelSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000))),
          titleLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          titleMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xdd000000))),
          titleSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xff000000)))),
      white: TextTheme(
          bodyLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          bodyMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          bodySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          displayLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          displayMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          displaySmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          headlineLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          headlineMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xb3ffffff))),
          headlineSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          labelLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          labelMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          labelSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          titleLarge: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          titleMedium: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff))),
          titleSmall: GoogleFonts.lexend(
              textStyle: TextStyle(color: Color(0xffffffff)))),
    ),
    applyElevationOverlayColor: false,
    canvasColor: Color(0xff1a1c19),
    cardColor: Color(0xff1a1c19),
    dialogBackgroundColor: Color(0xff1a1c19),
    disabledColor: Color(0x62ffffff),
    dividerColor: Color(0x1fe2e3dd),
    focusColor: Color(0x1fffffff),
    highlightColor: Color(0x40cccccc),
    hintColor: Color(0x99ffffff),
    hoverColor: Color(0x0affffff),
    indicatorColor: Color(0xffe2e3dd),
    inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        filled: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        isCollapsed: false,
        isDense: false),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    primaryColor: Color(0xff1f6c2f),
    primaryColorDark: Color(0xff1976d2),
    primaryColorLight: Color(0xffbbdefb),
    unselectedWidgetColor: Color(0xb3ffffff),
    visualDensity: VisualDensity.compact,
    colorScheme: ColorScheme(
        background: Color(0xff1a1c19),
        brightness: Brightness.light,
        error: Color(0xffffb4ab),
        errorContainer: Color(0xff93000a),
        inversePrimary: Color(0xff1f6c2f),
        inverseSurface: Color(0xffe2e3dd),
        onBackground: Color(0xffe2e3dd),
        onError: Color(0xff690005),
        onErrorContainer: Color(0xffffb4ab),
        onInverseSurface: Color(0xff2f312d),
        onPrimary: Color(0xff003910),
        onPrimaryContainer: Color(0xffb3f2b2),
        onSecondary: Color(0xffffffff),
        onSecondaryContainer: Color(0xffd4e8d0),
        onSurface: Color(0xffe2e3dd),
        onSurfaceVariant: Color(0xffc2c9bd),
        onTertiary: Color(0xff00363c),
        onTertiaryContainer: Color(0xffbcebf2),
        outline: Color(0xff8c9389),
        outlineVariant: Color(0xff424940),
        primary: Color(0xff8bd88e),
        primaryContainer: Color(0xff00531b),
        secondary: Color(0xffb9ccb5),
        secondaryContainer: Color(0xff3a4b39),
        shadow: Color(0xff000000),
        surface: Color(0xff1a1c19),
        surfaceTint: Color(0xff8bd88e),
        surfaceVariant: Color(0xff424940),
        tertiary: Color(0xffa1ced6),
        tertiaryContainer: Color(0xff1f4d53)),
    primaryTextTheme: TextTheme(
        bodyLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        bodyMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        bodySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displayLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displayMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        displaySmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xb3ffffff))),
        headlineSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        labelSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleLarge:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleMedium:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
        titleSmall:
            GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff)))),
    buttonTheme: ButtonThemeData(
      height: 36,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      minWidth: 88,
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignedDropdown: false,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff8bd88e),
        primaryContainer: Color(0xff00531b),
        onPrimary: Color(0xff003910),
        onPrimaryContainer: Color(0xffb3f2b2),
        secondary: Color(0xffb9ccb5),
        secondaryContainer: Color(0xff3a4b39),
        onSecondaryContainer: Color(0xffd4e8d0),
        onSecondary: Color(0xff243424),
        error: Color(0xffffb4ab),
        errorContainer: Color(0xff93000a),
        onError: Color(0xff690005),
        inversePrimary: Color(0xff1f6c2f),
        inverseSurface: Color(0xffe2e3dd),
        onErrorContainer: Color(0xffffb4ab),
        onInverseSurface: Color(0xff2f312d),
        background: Color(0xff1a1c19),
        onBackground: Color(0xffe2e3dd),
        shadow: Color(0xff000000),
        surface: Color(0xff1a1c19),
        surfaceTint: Color(0xff8bd88e),
        surfaceVariant: Color(0xff424940),
        tertiary: Color(0xffa1ced6),
        tertiaryContainer: Color(0xff1f4d53),
        onSurface: Color(0xffe2e3dd),
        onSurfaceVariant: Color(0xffc2c9bd),
        onTertiary: Color(0xff00363c),
        onTertiaryContainer: Color(0xffbcebf2),
        outline: Color(0xff8c9389),
        outlineVariant: Color(0xff424940),
      ),
    ),
  );
}
