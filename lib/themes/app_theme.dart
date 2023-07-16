import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get() {
    return ThemeData(
        fontFamily: "Lato",
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
        dividerTheme: DividerThemeData(color: surfaceColor(), space: 0),
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
