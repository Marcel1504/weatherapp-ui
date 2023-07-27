import 'package:flutter/material.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

enum AppSoilSortEnum {
  LATEST,
  OLDEST,
  HIGHEST_TEMPERATURE50CM,
  LOWEST_TEMPERATURE50CM,
  HIGHEST_TEMPERATURE100CM,
  LOWEST_TEMPERATURE100CM,
  HIGHEST_TEMPERATURE200CM,
  LOWEST_TEMPERATURE200CM;

  IconData getFilterIcon() {
    switch (this) {
      case AppSoilSortEnum.LATEST:
      case AppSoilSortEnum.OLDEST:
        return AppIcons.past;
      default:
        return Icons.thermostat;
    }
  }
}
