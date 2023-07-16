import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/data/single/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/fragments/text/app_square_positioned_text_fragment.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppWeatherCurrentDataFragment extends StatelessWidget {
  final AppStationResponseDto? station;

  const AppWeatherCurrentDataFragment({super.key, this.station});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppWeatherSingleDataProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);

    return Consumer<AppWeatherSingleDataProvider>(
        builder: (context, provider, widget) {
      return Center(child: _root(context, provider));
    });
  }

  Widget _root(BuildContext context, AppWeatherSingleDataProvider provider) {
    AppLayoutService layoutService = AppLayoutService();
    return provider.loading
        ? const AppLoadingFragment(
            size: 50,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _header(context, provider.latest, layoutService),
              Expanded(
                child: Center(
                    child: _display(context, provider.latest, layoutService)),
              )
            ],
          );
  }

  Widget _header(BuildContext context, AppWeatherSingleDataResponseDto? weather,
      AppLayoutService layoutService) {
    return Text(
      "HEADER",
      style:
          layoutService.appTextStyle(context, size: "l", color: "background"),
    );
  }

  Widget _display(
      BuildContext context,
      AppWeatherSingleDataResponseDto? weather,
      AppLayoutService layoutService) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: layoutService.maxWidth(),
          maxHeight: layoutService.maxWidth()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          List<Widget> displayList = [];
          displayList.add(_displayMainImage(context, layoutService));
          displayList.add(_displayNorthSymbol(context, constraints));
          displayList.add(_displaySouthSymbol(context, constraints));
          displayList.add(_displayEastSymbol(context, constraints));
          displayList.add(_displayWestSymbol(context, constraints));
          displayList.add(_displayTemperatureText(
              context, weather?.temperature, constraints));
          displayList
              .add(_displayWindSpeedText(context, weather?.wind, constraints));
          displayList.add(_displayWindDirectionText(
              context, weather?.windDirection, constraints));
          displayList.add(
              _displayHumidityText(context, weather?.humidity, constraints));
          displayList.add(
              _displayPressureText(context, weather?.pressure, constraints));
          if (weather?.windDirection != null) {
            displayList.add(_displayWindDirectionPointerImage(
                context, weather!.windDirection!, layoutService));
          }
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: displayList,
          );
        },
      ),
    );
  }

  Widget _displayMainImage(
      BuildContext context, AppLayoutService layoutService) {
    return layoutService.getImageAsset(context, "weather-display");
  }

  Widget _displayWindDirectionPointerImage(
      BuildContext context, int windDirection, AppLayoutService layoutService) {
    return RotationTransition(
        turns: AlwaysStoppedAnimation(windDirection / 360),
        child: layoutService.getImageAsset(
            context, "weather-display-wind-direction-pointer"));
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

  Widget _displayTemperatureText(
      BuildContext context, double? temperature, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: "${temperature ?? '--'}°C",
      squareSize: baseSize,
      textDensity: 18,
      backgroundDensity: 28,
      backgroundOpacity: 0.05,
      color: AppColorService().temperatureToColor(context, temperature),
      top: baseSize / 2,
      left: baseSize / 2,
    );
  }

  Widget _displayWindSpeedText(
      BuildContext context, double? wind, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: "300km/h",
      //"${wind ?? '--'}km/h",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 6,
      color: Theme.of(context).colorScheme.onBackground,
      icon: AppIcons.wind,
      top: baseSize / 1.5,
      left: baseSize / 3,
    );
  }

  Widget _displayWindDirectionText(
      BuildContext context, int? windDirection, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: "${windDirection ?? '--'}°",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 6,
      color: Theme.of(context).colorScheme.onBackground,
      icon: AppIcons.winddirection,
      top: baseSize / 1.5,
      right: baseSize / 3,
    );
  }

  Widget _displayHumidityText(
      BuildContext context, int? humidity, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: "${humidity ?? '--'}%",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 6,
      icon: AppIcons.drop,
      color: Theme.of(context).colorScheme.onBackground,
      top: baseSize / 3,
      right: baseSize / 3,
    );
  }

  Widget _displayPressureText(
      BuildContext context, double? pressure, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: "1024.2hpa",
      //"""${pressure ?? '--'}hpa",
      squareSize: baseSize,
      textDensity: 3.5,
      backgroundDensity: 7,
      icon: Icons.speed,
      color: Theme.of(context).colorScheme.onBackground,
      bottom: baseSize / 4,
      right: baseSize / 2,
    );
  }

  double _baseSize(BoxConstraints constraints) {
    return math.min(constraints.maxWidth, constraints.maxHeight);
  }
}
