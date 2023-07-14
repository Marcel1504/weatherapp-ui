import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  @override
  Color backgroundColor() {
    return const Color.fromRGBO(233, 233, 233, 1.0);
  }

  @override
  Color onBackgroundColor() {
    return Colors.black;
  }

  @override
  Color surfaceColor() {
    return const Color.fromRGBO(213, 213, 213, 1.0);
  }

  @override
  Color onSurfaceColor() {
    return Colors.black;
  }

  @override
  Color primaryColor() {
    return const Color.fromRGBO(47, 137, 6, 1.0);
  }

  @override
  Color onPrimaryColor() {
    return Colors.white;
  }

  @override
  Color secondaryColor() {
    return const Color.fromRGBO(98, 203, 53, 1.0);
  }

  @override
  Color onSecondaryColor() {
    return Colors.black;
  }

  @override
  Color tertiaryColor() {
    return const Color.fromRGBO(179, 187, 172, 1.0);
  }

  @override
  Color onTertiaryColor() {
    return Colors.black;
  }

  @override
  Color errorColor() {
    return const Color.fromRGBO(163, 20, 20, 1.0);
  }

  @override
  Color onErrorColor() {
    return Colors.white;
  }

  @override
  Brightness brightness() {
    return Brightness.light;
  }
}
