import 'package:flutter/material.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

enum AppWeatherSortEnum {
  LATEST,
  OLDEST,
  HIGHEST_TEMPERATURE,
  LOWEST_TEMPERATURE,
  HIGHEST_HUMIDITY,
  LOWEST_HUMIDITY,
  HIGHEST_PRESSURE,
  LOWEST_PRESSURE,
  HIGHEST_SOLAR_RADIATION,
  LOWEST_SOLAR_RADIATION,
  MOST_RAIN,
  STRONGEST_WIND;

  IconData getFilterIcon() {
    switch (this) {
      case AppWeatherSortEnum.LATEST:
      case AppWeatherSortEnum.OLDEST:
        return AppIcons.past;
      case AppWeatherSortEnum.HIGHEST_TEMPERATURE:
      case AppWeatherSortEnum.LOWEST_TEMPERATURE:
        return Icons.thermostat;
      case AppWeatherSortEnum.HIGHEST_HUMIDITY:
      case AppWeatherSortEnum.LOWEST_HUMIDITY:
        return AppIcons.humidity;
      case AppWeatherSortEnum.HIGHEST_PRESSURE:
      case AppWeatherSortEnum.LOWEST_PRESSURE:
        return Icons.speed;
      case AppWeatherSortEnum.HIGHEST_SOLAR_RADIATION:
      case AppWeatherSortEnum.LOWEST_SOLAR_RADIATION:
        return Icons.sunny;
      case AppWeatherSortEnum.MOST_RAIN:
        return AppIcons.rain;
      case AppWeatherSortEnum.STRONGEST_WIND:
        return AppIcons.wind;
    }
  }
}
