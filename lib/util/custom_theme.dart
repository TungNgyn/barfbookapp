import 'dart:ui';

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
      textTheme: TextTheme(
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
              textStyle: TextStyle(color: Color(0xdd000000))),
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
      typography: Typography(
          black: TextTheme(bodyLarge: TextStyle(color: Color(0xdd000000)))),
      applyElevationOverlayColor: false,
      canvasColor: Color(0xfffafafa),
      cardColor: Color(0xffffffff),
      dialogBackgroundColor: Color(0xffffffff),
      disabledColor: Color(0x61000000),
      dividerColor: Color(0x1f000000),
      focusColor: Color(0x1f000000),
      highlightColor: Color(0x66bcbcbc),
      hintColor: Color(0x99000000),
      hoverColor: Color(0x0a000000),
      indicatorColor: Color(0xff679267),
      inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: false,
          filled: false,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          isCollapsed: false,
          isDense: false),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      primaryColor: Color(0xff679267),
      primaryColorDark: Color(0xff527552),
      primaryColorLight: Color(0xffa4bea4),
      unselectedWidgetColor: Color(0x8a000000),
      visualDensity: VisualDensity.compact,
      colorScheme: ColorScheme(
          background: Color(0xffffffff),
          brightness: Brightness.light,
          error: Color(0xffffffff),
          errorContainer: Color(0xffb00020),
          inversePrimary: Color(0xffffffff),
          inverseSurface: Color(0xff000000),
          onBackground: Color(0xff000000),
          onError: Color(0xffffffff),
          onErrorContainer: Color(0xffffffff),
          onInverseSurface: Color(0xffffffff),
          onPrimary: Color(0xff000000),
          onPrimaryContainer: Color(0xffffffff),
          onSecondary: Color(0xff000000),
          onSecondaryContainer: Color(0xff000000),
          onSurface: Color(0xff000000),
          onSurfaceVariant: Color(0xff000000),
          onTertiary: Color(0xff000000),
          onTertiaryContainer: Color(0xff000000),
          outline: Color(0xff000000),
          primary: Color(0xff679267),
          primaryContainer: Color(0xff6200ee),
          secondary: Color(0xff679267),
          secondaryContainer: Color(0xff03dac6),
          shadow: Color(0xff000000),
          surface: Color(0xffffffff),
          surfaceTint: Color(0xff6200ee),
          surfaceVariant: Color(0xffffffff),
          tertiary: Color(0xff03dac6),
          tertiaryContainer: Color(0xff03dac6)),
      primaryTextTheme: TextTheme(
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
          headlineSmall:
              GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          labelLarge: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          labelMedium: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          labelSmall: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          titleLarge: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          titleMedium: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          titleSmall: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff)))),
      buttonTheme: ButtonThemeData(
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
            error: Color(0xffba1a1a),errorContainer: Color(0xffffdad6),
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
            outline: Color(0xff72796f),outlineVariant: Color(0xffc2c9bd)
          )));

  static final ThemeData classicDark = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: Color(0xfffcfdf7),
      secondaryHeaderColor: Color(0xffe3f2fd),
      shadowColor: Color(0xff000000),
      splashColor: Color(0x66c8c8c8),
      splashFactory: InkSplash.splashFactory,
      typography: Typography(
          black: TextTheme(bodyLarge: TextStyle(color: Color(0xdd000000)))),
      applyElevationOverlayColor: false,
      canvasColor: Color(0xfffafafa),
      cardColor: Color(0xffffffff),
      dialogBackgroundColor: Color(0xffffffff),
      disabledColor: Color(0x61000000),
      dividerColor: Color(0x1f000000),
      focusColor: Color(0x1f000000),
      highlightColor: Color(0x66bcbcbc),
      hintColor: Color(0x99000000),
      hoverColor: Color(0x0a000000),
      indicatorColor: Color(0xff679267),
      inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: false,
          filled: false,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          isCollapsed: false,
          isDense: false),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      primaryColor: Color(0xff679267),
      primaryColorDark: Color(0xff527552),
      primaryColorLight: Color(0xffa4bea4),
      unselectedWidgetColor: Color(0x8a000000),
      visualDensity: VisualDensity.compact,
      textTheme: TextTheme(
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
              textStyle: TextStyle(color: Color(0xdd000000))),
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
      colorScheme: ColorScheme(
          background: Color(0xffffffff),
          brightness: Brightness.light,
          error: Color(0xffffffff),
          errorContainer: Color(0xff410002),
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
          // outlineVariant: Col
          primary: Color(0xff679267),
          primaryContainer: Color(0xff6200ee),
          secondary: Color(0xff679267),
          secondaryContainer: Color(0xff03dac6),
          shadow: Color(0xff000000),
          surface: Color(0xffffffff),
          surfaceTint: Color(0xff6200ee),
          surfaceVariant: Color(0xffffffff),
          tertiary: Color(0xff03dac6),
          tertiaryContainer: Color(0xff03dac6)),
      primaryTextTheme: TextTheme(
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
          labelLarge: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          labelMedium: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          labelSmall: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          titleLarge: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          titleMedium: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff))),
          titleSmall: GoogleFonts.lexend(textStyle: TextStyle(color: Color(0xffffffff)))),
      buttonTheme: ButtonThemeData(
          height: 36,
          layoutBehavior: ButtonBarLayoutBehavior.padded,
          minWidth: 88,
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignedDropdown: false,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xff679267),
            primaryContainer: Color(0xff6200ee),
            onPrimary: Color(0xff000000),
            onPrimaryContainer: Color(0xffffffff),
            secondary: Color(0xff679267),
            secondaryContainer: Color(0xff03dac6),
            onSecondaryContainer: Color(0xff000000),
            onSecondary: Color(0xff000000),
            error: Color(0xffffb4ab),
            errorContainer: Color(0xff93000a),
            onError: Color(0xffffffff),
            inversePrimary: Color(0xffffffff),
            inverseSurface: Color(0xff000000),
            onErrorContainer: Color(0xffffffff),
            onInverseSurface: Color(0xffffffff),
            background: Color(0xffffffff),
            onBackground: Color(0xff000000),
            shadow: Color(0xff000000),
            surface: Color(0xffffffff),
            surfaceTint: Color(0xff6200ee),
            surfaceVariant: Color(0xffffffff),
            tertiary: Color(0xff03dac6),
            tertiaryContainer: Color(0xff03dac6),
            onSurface: Color(0xff000000),
            onSurfaceVariant: Color(0xff000000),
            onTertiary: Color(0xff000000),
            onTertiaryContainer: Color(0xff000000),
            outline: Color(0xff000000),
          )));
}
