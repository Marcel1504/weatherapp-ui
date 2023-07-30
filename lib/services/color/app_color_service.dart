import 'package:flutter/material.dart';

class AppColorService {
  Color temperatureToColor(BuildContext context, double? temperature,
      {bool blend = true}) {
    Color color;
    if (temperature == null) {
      color = const Color.fromRGBO(119, 119, 119, 1);
    } else {
      double hue = (1.0 - _percentageInValueRange(temperature, 30, -15)) * 270;
      color = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
    }
    return Color.alphaBlend(color.withOpacity(blend ? 0.7 : 1),
        Theme.of(context).colorScheme.onBackground);
  }

  LinearGradient temperaturesLinearGradient(
      BuildContext context, List<double?> temperatures, int stopSize) {
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
    min = min ?? -15;
    max = max ?? 30;
    double diff = max - min;
    List<Color> colors = [];
    List<double> stops = [];
    for (int i = 0; i <= stopSize; i++) {
      stops.add(i / stopSize);
      colors.add(Color.alphaBlend(
          temperatureToColor(context, min + i * (diff / stopSize))
              .withOpacity(0.9),
          Theme.of(context).colorScheme.onBackground));
    }
    return LinearGradient(
        colors: colors,
        stops: stops,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);
  }

  Color valueToColor(BuildContext context, double? value, Color base,
      {bool blend = true}) {
    if (value == null || value > 1) {
      value = 1;
    }
    if (value < 0) {
      value = 0;
    }
    Color color = HSVColor.fromColor(base).withSaturation(value).toColor();
    return Color.alphaBlend(color.withOpacity(blend ? 0.9 : 1),
        Theme.of(context).colorScheme.onBackground);
  }

  LinearGradient valueLinearGradient(BuildContext context, double? value,
      double lowest, double highest, Color base) {
    Color topColor = valueToColor(context,
        0.2 + (_percentageInValueRange(value, highest, lowest) * 0.8), base);
    return LinearGradient(
        colors: [valueToColor(context, 0.2, base), topColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);
  }

  LinearGradient valueListLinearGradient(BuildContext context,
      List<double?> values, double lowest, double highest, Color base) {
    double? maxValue;
    double? minValue;
    for (double? v in values) {
      if (maxValue == null || (v != null && v > maxValue)) {
        maxValue = v;
      }
      if (minValue == null || (v != null && v < minValue)) {
        minValue = v;
      }
    }
    minValue = minValue != null && minValue >= lowest ? minValue : lowest;
    maxValue = maxValue != null && maxValue <= highest ? maxValue : highest;
    Color bottomColor = valueToColor(context,
        0.2 + (_percentageInValueRange(minValue, highest, lowest) * 0.8), base);
    Color topColor = valueToColor(context,
        0.2 + (_percentageInValueRange(maxValue, highest, lowest) * 0.8), base);
    return LinearGradient(
        colors: [bottomColor, topColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);
  }

  double _percentageInValueRange(double? value, double max, double min) {
    if (value == null || value > max) return 1;
    if (value < min) return 0;
    return 1 - ((max - value) / (max - min));
  }
}
