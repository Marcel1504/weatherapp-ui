import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

abstract class AppTheme {
  ThemeData get() {
    return ThemeData(
        fontFamily: "Lato",
        textTheme: TextTheme(
          labelSmall: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextLabel),
              fontSize: AppLayoutConfig.defaultTextLabelFontSize,
              fontWeight: FontWeight.w300),
          labelMedium: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextLabel),
              fontSize: AppLayoutConfig.defaultTextLabelFontSize,
              fontWeight: FontWeight.w400),
          labelLarge: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextLabel),
              fontSize: AppLayoutConfig.defaultTextLabelFontSize,
              fontWeight: FontWeight.w700),
          bodySmall: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextBody),
              fontSize: AppLayoutConfig.defaultTextBodyFontSize,
              fontWeight: FontWeight.w300),
          bodyMedium: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextBody),
              fontSize: AppLayoutConfig.defaultTextBodyFontSize,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextBody),
              fontSize: AppLayoutConfig.defaultTextBodyFontSize,
              fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextHeadline),
              fontSize: AppLayoutConfig.defaultTextHeadlineFontSize,
              fontWeight: FontWeight.w300),
          headlineMedium: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextHeadline),
              fontSize: AppLayoutConfig.defaultTextHeadlineFontSize,
              fontWeight: FontWeight.w400),
          headlineLarge: TextStyle(
              color: onSurfaceColor().withOpacity(AppLayoutConfig.opacityTextHeadline),
              fontSize: AppLayoutConfig.defaultTextHeadlineFontSize,
              fontWeight: FontWeight.w700),
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: errorColor(), contentTextStyle: TextStyle(color: onErrorColor(), fontSize: 16)),
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(secondaryColor()), thickness: MaterialStateProperty.all(8)),
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
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
        ),
        listTileTheme: const ListTileThemeData(tileColor: Colors.transparent, contentPadding: EdgeInsets.all(10)),
        dividerTheme: DividerThemeData(color: surfaceColor(), space: 0, thickness: 1),
        dialogTheme: DialogTheme(
            actionsPadding: const EdgeInsets.all(20),
            titleTextStyle: TextStyle(color: onBackgroundColor().withOpacity(0.7), fontSize: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: backgroundColor()),
        appBarTheme: AppBarTheme(
            titleSpacing: 10,
            backgroundColor: Colors.transparent,
            foregroundColor: onBackgroundColor(),
            elevation: 0,
            toolbarHeight: 55));
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
