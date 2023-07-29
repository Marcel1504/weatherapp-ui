import 'package:flutter/material.dart';

class AppColorService {
  final int tempMin = -15;
  final int tempMax = 30;

  Color temperatureToColor(BuildContext context, double? temperature) {
    Color color;
    if (temperature == null) {
      color = const Color.fromRGBO(119, 119, 119, 1);
    } else {
      double hue = _percentageInTemperatureRange(temperature.toInt()) * 270;
      color = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
    }
    return Color.alphaBlend(
        color.withOpacity(0.7), Theme
        .of(context)
        .colorScheme
        .onBackground);
  }

  LinearGradient getTemperatureColoredLineGradient(BuildContext context,
      List<double?> temperatures, int stopSize) {
    AppColorService colorService = AppColorService();
    double? max;
    double? min;
    for (double? t in temperatures) {
      if (max == null || (t != null && t > max)) {
        max = t;
      }
      if (min == null || (t != null && t < min)) {
        min = t;
      }
    }
    min = min ?? -30;
    max = max ?? 40;
    double diff = max - min;
    List<Color> colors = [];
    List<double> stops = [];
    for (int i = 0; i <= stopSize; i++) {
      stops.add(i / stopSize);
      colors.add(Color.alphaBlend(
          colorService
              .temperatureToColor(context, min + i * (diff / stopSize))
              .withOpacity(0.9),
          Theme
              .of(context)
              .colorScheme
              .onBackground));
    }
    return LinearGradient(
        colors: colors,
        stops: stops,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);
  }

  double _percentageInTemperatureRange(int temperature) {
    if (temperature < tempMin) return 1;
    if (temperature > tempMax) return 0;
    return (tempMax - temperature) / (tempMax - tempMin);
  }
}
