import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/dto/response/summary/single/weather/app_weather_single_summary_response_dto.dart';
import 'package:weatherapp_ui/fragments/text/app_square_positioned_text_fragment.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppWeatherCurrentDataDisplayFragment extends StatelessWidget {
  final AppWeatherSingleSummaryResponseDto? weather;

  const AppWeatherCurrentDataDisplayFragment({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: layoutService.maxWidth(), maxHeight: layoutService.maxWidth()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: _getDisplayList(context, constraints),
          );
        },
      ),
    );
  }

  List<Widget> _getDisplayList(BuildContext context, BoxConstraints constraints) {
    List<Widget> displayList = [];
    displayList.add(_displayMainImage(context));
    displayList.add(_displayNorthSymbol(context, constraints));
    displayList.add(_displaySouthSymbol(context, constraints));
    displayList.add(_displayEastSymbol(context, constraints));
    displayList.add(_displayWestSymbol(context, constraints));
    displayList.add(_displayTemperatureText(context, constraints));
    displayList.add(_displayRainText(context, constraints));
    displayList.add(_displaySolarRadiationText(context, constraints));
    displayList.add(_displayWindSpeedText(context, constraints));
    displayList.add(_displayWindDirectionText(context, constraints));
    displayList.add(_displayHumidityText(context, constraints));
    displayList.add(_displayPressureText(context, constraints));
    if (weather?.windDirection != null) {
      displayList.add(_displayWindDirectionPointerImage(context, weather!.windDirection!));
    }
    return displayList;
  }

  Widget _displayMainImage(BuildContext context) {
    return AppLayoutService().getImageAsset(context, "weather-display");
  }

  Widget _displayWindDirectionPointerImage(BuildContext context, int windDirection) {
    return RotationTransition(
        turns: AlwaysStoppedAnimation(windDirection / 360),
        child: AppLayoutService().getImageAsset(context, "weather-display-wind-direction-pointer"));
  }

  Widget _displayNorthSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: AppLocalizations.of(context)!.weather_wind_direction_north,
        left: baseSize / 2,
        top: baseSize / 30,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 3.5);
  }

  Widget _displaySouthSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: AppLocalizations.of(context)!.weather_wind_direction_south,
        left: baseSize / 2,
        bottom: baseSize / 30,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 3.5);
  }

  Widget _displayEastSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      squareSize: baseSize,
      text: AppLocalizations.of(context)!.weather_wind_direction_east,
      right: baseSize / 30,
      top: baseSize / 2,
      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
      textDensity: 3.5,
      backgroundDensity: 3.5,
    );
  }

  Widget _displayWestSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      squareSize: baseSize,
      text: AppLocalizations.of(context)!.weather_wind_direction_west,
      left: baseSize / 30,
      top: baseSize / 2,
      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
      textDensity: 3.5,
      backgroundDensity: 3.5,
    );
  }

  Widget _displayTemperatureText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: weather?.temperature != null ? "${weather?.temperature} °C" : "--",
      squareSize: baseSize,
      textDensity: 18,
      backgroundDensity: 28,
      backgroundOpacity: 0.05,
      color: AppColorService().temperatureToColor(context, weather?.temperature),
      top: baseSize / 2,
      left: baseSize / 2,
    );
  }

  Widget _displayWindSpeedText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: weather?.wind != null ? "${weather?.wind} km/h" : "--",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 7,
      color: Theme.of(context).colorScheme.onBackground,
      icon: AppIcons.wind,
      top: baseSize / 1.5,
      left: baseSize / 3,
    );
  }

  Widget _displayWindDirectionText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: weather?.windDirection != null ? "${weather?.windDirection}°" : "--",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 6,
      color: Theme.of(context).colorScheme.onBackground,
      icon: AppIcons.winddirection,
      top: baseSize / 1.5,
      right: baseSize / 3,
    );
  }

  Widget _displayHumidityText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: weather?.humidity != null ? "${weather?.humidity}%" : "--",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 6,
      icon: AppIcons.humidity,
      color: Theme.of(context).colorScheme.onBackground,
      top: baseSize / 3,
      right: baseSize / 3,
    );
  }

  Widget _displayRainText(BuildContext context, BoxConstraints constraints) {
    String? rainText;
    Color color = Theme.of(context).colorScheme.onBackground;
    if (weather?.lastRain != null) {
      String? duration = AppTimeService().transformISOTimeStringToCurrentDuration(context, weather?.lastRain);
      if (duration != null) {
        rainText = AppLocalizations.of(context)!.weather_last_rain_duration(duration);
      }
    } else if (weather?.rainRate != null) {
      rainText = "${weather?.rainRate.toString()} mm/h";
      color = Color.alphaBlend(const Color.fromRGBO(0, 175, 255, 0.7), Theme.of(context).colorScheme.onBackground);
    }
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: rainText ?? '--',
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 6,
      icon: AppIcons.rain,
      color: color,
      top: baseSize / 4.5,
      right: baseSize / 2,
    );
  }

  Widget _displayPressureText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: weather?.pressure != null ? "${weather?.pressure} hpa" : "--",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 7,
      icon: Icons.speed,
      color: Theme.of(context).colorScheme.onBackground,
      bottom: baseSize / 4.5,
      right: baseSize / 2,
    );
  }

  Widget _displaySolarRadiationText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: weather?.solarRadiation != null ? "${weather?.solarRadiation} w/m²" : "--",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 7,
      icon: Icons.sunny,
      color: Theme.of(context).colorScheme.onBackground,
      top: baseSize / 3,
      left: baseSize / 3,
    );
  }

  double _baseSize(BoxConstraints constraints) {
    return math.min(constraints.maxWidth, constraints.maxHeight);
  }
}
