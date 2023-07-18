import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get() {
    return ThemeData(
        fontFamily: "Lato",
        textTheme: TextTheme(
          bodySmall: TextStyle(
              color: onBackgroundColor().withOpacity(0.7), fontSize: 14),
          bodyMedium: TextStyle(
              color: onBackgroundColor().withOpacity(0.7), fontSize: 18),
          bodyLarge: TextStyle(
              color: onBackgroundColor().withOpacity(0.7), fontSize: 22),
          headlineSmall: TextStyle(color: onBackgroundColor(), fontSize: 14),
          headlineMedium: TextStyle(color: onBackgroundColor(), fontSize: 18),
          headlineLarge: TextStyle(color: onBackgroundColor(), fontSize: 22),
        ),
        colorScheme: ColorScheme(
            background: backgroundColor(),
            brightness: brightness(),
            primary: primaryColor(),
            onPrimary: onPrimaryColor(),
            secondary: secondaryColor(),
            onSecondary: onSecondaryColor(),
            tertiary: tertiaryColor(),
            onTertiary: onTertiaryColor(),
            error: errorColor(),
            onError: onErrorColor(),
            onBackground: onBackgroundColor(),
            surface: surfaceColor(),
            onSurface: onSurfaceColor()),
        scaffoldBackgroundColor: backgroundColor(),
        listTileTheme: const ListTileThemeData(
            tileColor: Colors.transparent, contentPadding: EdgeInsets.all(10)),
        dividerTheme:
            DividerThemeData(color: surfaceColor(), space: 0, thickness: 1),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: onBackgroundColor(),
            elevation: 0));
  }

  Color backgroundColor();

  Color onBackgroundColor();

  Color surfaceColor();

  Color onSurfaceColor();

  Color primaryColor();

  Color onPrimaryColor();

  Color secondaryColor();

  Color onSecondaryColor();

  Color tertiaryColor();

  Color onTertiaryColor();

  Color errorColor();

  Color onErrorColor();

  Brightness brightness();
}
