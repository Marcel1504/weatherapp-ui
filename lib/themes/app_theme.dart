import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get() {
    return ThemeData(
        fontFamily: "Lato",
        textTheme: TextTheme(
          bodySmall: TextStyle(
              color: onBackgroundColor().withOpacity(0.7), fontSize: 14),
          bodyMedium: TextStyle(
              color: onBackgroundColor().withOpacity(0.7), fontSize: 16),
          bodyLarge: TextStyle(
              color: onBackgroundColor().withOpacity(0.7), fontSize: 18),
          headlineSmall: TextStyle(color: onBackgroundColor(), fontSize: 14),
          headlineMedium: TextStyle(color: onBackgroundColor(), fontSize: 16),
          headlineLarge: TextStyle(color: onBackgroundColor(), fontSize: 18),
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: errorColor(),
            contentTextStyle: TextStyle(color: onErrorColor(), fontSize: 16)),
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(tertiaryColor()),
            thickness: MaterialStateProperty.all(8)),
        chipTheme: ChipThemeData(
            selectedColor: secondaryColor(),
            elevation: 0,
            side: BorderSide.none,
            pressElevation: 0,
            padding: const EdgeInsets.all(10),
            backgroundColor: surfaceColor(),
            labelStyle: TextStyle(fontSize: 16, color: onSurfaceColor())),
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
        scaffoldBackgroundColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        listTileTheme: const ListTileThemeData(
            tileColor: Colors.transparent, contentPadding: EdgeInsets.all(10)),
        dividerTheme:
            DividerThemeData(color: surfaceColor(), space: 0, thickness: 1),
        dialogTheme: DialogTheme(
            actionsPadding: const EdgeInsets.all(20),
            titleTextStyle: TextStyle(
                color: onBackgroundColor().withOpacity(0.7), fontSize: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: backgroundColor()),
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
