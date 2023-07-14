import 'package:flutter/material.dart';

class AppLayoutService {
  TextStyle appTextStyle(BuildContext context,
      {bool withOpacity = false, String size = "m", String color = "surface"}) {
    double fontSize;
    switch (size) {
      case "m":
        fontSize = 16;
        break;
      case "l":
        fontSize = 20;
        break;
      case "xl":
        fontSize = 24;
        break;
      case "s":
      default:
        fontSize = 12;
    }
    Color colorValue;
    switch (color) {
      case "primary":
        colorValue = Theme.of(context).colorScheme.onPrimary;
        break;
      case "background":
        colorValue = Theme.of(context).colorScheme.onBackground;
        break;
      case "surface":
      default:
        colorValue = Theme.of(context).colorScheme.onSurface;
    }
    return TextStyle(
        fontSize: fontSize,
        color: colorValue.withOpacity(withOpacity ? 0.7 : 1.0));
  }

  double betweenItemPadding() {
    return 10;
  }

  double maxWidth() {
    return 500;
  }
}
