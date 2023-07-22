import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/dto/response/data/single/soil/app_soil_single_data_response_dto.dart';
import 'package:weatherapp_ui/fragments/text/app_square_positioned_text_fragment.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppSoilCurrentDataDisplayFragment extends StatelessWidget {
  final AppSoilSingleDataResponseDto? soil;

  const AppSoilCurrentDataDisplayFragment({super.key, this.soil});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: layoutService.maxWidth(),
          maxHeight: layoutService.maxWidth()),
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

  List<Widget> _getDisplayList(
      BuildContext context, BoxConstraints constraints) {
    List<Widget> displayList = [];
    displayList.add(_displayMainImage(context));
    displayList.add(_displayDeepnessHeader(context, constraints));
    displayList.add(_display0cmSymbol(context, constraints));
    displayList.add(_display50cmSymbol(context, constraints));
    displayList.add(_display100cmSymbol(context, constraints));
    displayList.add(_display150cmSymbol(context, constraints));
    displayList.add(_display200cmSymbol(context, constraints));
    displayList.add(_displayTemperature50cmText(context, constraints));
    displayList.add(_displayTemperature100cmText(context, constraints));
    displayList.add(_displayTemperature200cmText(context, constraints));
    return displayList;
  }

  Widget _displayMainImage(BuildContext context) {
    return AppLayoutService().getImageAsset(context, "soil-display");
  }

  Widget _displayDeepnessHeader(
      BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: AppLocalizations.of(context)!.soil_deepness,
        left: baseSize / 2,
        top: baseSize * 0.05,
        color: Theme.of(context).colorScheme.onBackground,
        textDensity: 4.5,
        backgroundDensity: 4.5);
  }

  Widget _display0cmSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: "0cm",
        left: baseSize / 2.5,
        top: baseSize * 0.14,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 4.5);
  }

  Widget _display50cmSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: "50cm",
        left: baseSize / 2.5,
        top: baseSize * 0.316,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 4.5);
  }

  Widget _display100cmSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: "100cm",
        left: baseSize / 2.5,
        top: baseSize / 2,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 4.5);
  }

  Widget _display150cmSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: "150cm",
        left: baseSize / 2.5,
        bottom: baseSize * 0.316,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 4.5);
  }

  Widget _display200cmSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
        squareSize: baseSize,
        text: "200cm",
        left: baseSize / 2.5,
        bottom: baseSize * 0.14,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 4.5);
  }

  Widget _displayTemperature50cmText(
      BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text: soil?.temperature50cm != null ? "${soil?.temperature50cm} °C" : "",
      squareSize: baseSize,
      textDensity: 5,
      backgroundDensity: 7,
      color:
          AppColorService().temperatureToColor(context, soil?.temperature50cm),
      right: baseSize / 2.7,
      top: baseSize * 0.316,
    );
  }

  Widget _displayTemperature100cmText(
      BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text:
          soil?.temperature100cm != null ? "${soil?.temperature100cm} °C" : "",
      squareSize: baseSize,
      textDensity: 5,
      backgroundDensity: 7,
      color:
          AppColorService().temperatureToColor(context, soil?.temperature100cm),
      right: baseSize / 2.7,
      top: baseSize / 2,
    );
  }

  Widget _displayTemperature200cmText(
      BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextFragment(
      text:
          soil?.temperature200cm != null ? "${soil?.temperature200cm} °C" : "",
      squareSize: baseSize,
      textDensity: 5,
      backgroundDensity: 7,
      color:
          AppColorService().temperatureToColor(context, soil?.temperature200cm),
      right: baseSize / 2.7,
      bottom: baseSize * 0.14,
    );
  }

  double _baseSize(BoxConstraints constraints) {
    return math.min(constraints.maxWidth, constraints.maxHeight);
  }
}
