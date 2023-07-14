import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppThemeDark extends AppTheme {
  @override
  Color backgroundColor() {
    return const Color.fromRGBO(28, 28, 28, 1.0);
  }

  @override
  Color onBackgroundColor() {
    return Colors.white;
  }

  @override
  Color surfaceColor() {
    return const Color.fromRGBO(45, 45, 45, 1.0);
  }

  @override
  Color onSurfaceColor() {
    return Colors.white;
  }

  @override
  Color primaryColor() {
    return const Color.fromRGBO(66, 200, 9, 1.0);
  }

  @override
  Color onPrimaryColor() {
    return Colors.white;
  }

  @override
  Color secondaryColor() {
    return const Color.fromRGBO(45, 137, 6, 1.0);
  }

  @override
  Color onSecondaryColor() {
    return Colors.white;
  }

  @override
  Color tertiaryColor() {
    return const Color.fromRGBO(67, 78, 65, 1.0);
  }

  @override
  Color onTertiaryColor() {
    return Colors.white;
  }

  @override
  Color errorColor() {
    return const Color.fromRGBO(240, 60, 60, 1.0);
  }

  @override
  Color onErrorColor() {
    return Colors.white;
  }

  @override
  Brightness brightness() {
    return Brightness.dark;
  }
}
