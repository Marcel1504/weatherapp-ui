import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/text/app_square_positioned_text_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/summary/single/soil/app_soil_single_summary_response_dto.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';

class AppSoilCurrentSummaryFragment extends StatelessWidget {
  final AppSoilSingleSummaryResponseDto? soil;

  const AppSoilCurrentSummaryFragment({super.key, this.soil});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxWidth: AppLayoutConfig.defaultMaxWidth, maxHeight: AppLayoutConfig.defaultMaxWidth),
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
    return AppLayoutConfig.getImageAsset(context, "soil-display");
  }

  Widget _displayDeepnessHeader(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextComponent(
        squareSize: baseSize,
        text: AppL18nConfig.get(context).soil_depth,
        left: baseSize / 2,
        top: baseSize * 0.05,
        color: Theme.of(context).colorScheme.onBackground,
        textDensity: 4.5,
        backgroundDensity: 4.5);
  }

  Widget _display0cmSymbol(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextComponent(
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
    return AppSquarePositionedTextComponent(
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
    return AppSquarePositionedTextComponent(
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
    return AppSquarePositionedTextComponent(
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
    return AppSquarePositionedTextComponent(
        squareSize: baseSize,
        text: "200cm",
        left: baseSize / 2.5,
        bottom: baseSize * 0.14,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        textDensity: 3.5,
        backgroundDensity: 4.5);
  }

  Widget _displayTemperature50cmText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextComponent(
      text: soil?.temperature50cm != null ? "${soil?.temperature50cm} °C" : "",
      squareSize: baseSize,
      textDensity: 5,
      backgroundDensity: 7,
      color: AppColorService().temperatureToColor(context, soil?.temperature50cm),
      right: baseSize / 2.7,
      top: baseSize * 0.316,
    );
  }

  Widget _displayTemperature100cmText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextComponent(
      text: soil?.temperature100cm != null ? "${soil?.temperature100cm} °C" : "",
      squareSize: baseSize,
      textDensity: 5,
      backgroundDensity: 7,
      color: AppColorService().temperatureToColor(context, soil?.temperature100cm),
      right: baseSize / 2.7,
      top: baseSize / 2,
    );
  }

  Widget _displayTemperature200cmText(BuildContext context, BoxConstraints constraints) {
    double baseSize = _baseSize(constraints);
    return AppSquarePositionedTextComponent(
      text: soil?.temperature200cm != null ? "${soil?.temperature200cm} °C" : "",
      squareSize: baseSize,
      textDensity: 5,
      backgroundDensity: 7,
      color: AppColorService().temperatureToColor(context, soil?.temperature200cm),
      right: baseSize / 2.7,
      bottom: baseSize * 0.14,
    );
  }

  double _baseSize(BoxConstraints constraints) {
    return math.min(constraints.maxWidth, constraints.maxHeight);
  }
}
