import 'package:flutter/material.dart';

class AppColorService {
  final int tempMin = -20;
  final int tempMax = 35;

  Color temperatureToColor(BuildContext context, double? temperature) {
    Color color;
    if (temperature == null) {
      color = const Color.fromRGBO(119, 119, 119, 1);
    } else {
      double hue = _percentageInTemperatureRange(temperature.toInt()) * 270;
      color = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
    }
    return Color.alphaBlend(
        color.withOpacity(0.7), Theme.of(context).colorScheme.onBackground);
  }

  double _percentageInTemperatureRange(int temperature) {
    if (temperature < tempMin) return 1;
    if (temperature > tempMax) return 0;
    return (tempMax - temperature) / (tempMax - tempMin);
  }
}
