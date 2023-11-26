import 'package:flutter/material.dart';

class AppLayoutConfig {
  // button
  static const double buttonDefaultSize = 50;
  static const double buttonReviewFilterSize = 36;

  // chart
  static const double chartBottomTitleFontSize = 16;
  static const double chartNoDataFontSize = 18;
  static const double chartTooltipFontSize = 16;

  // chat
  static const double chatMessageBorderRadius = 15;
  static const double chatMessageContentSpacing = 10;
  static const double chatMessageFontSize = 18;
  static const double chatMessageSpacing = 10;

  // chip
  static const double chipFontSize = 18;

  // dialog
  static const double dialogTitleFontSize = 18;

  // input
  static const double inputBorderDefaultWidth = 1;
  static const double inputDefaultSize = 50;

  // list
  static const double listSortFontSize = 16;
  static const double listSummarySoilLabelFontSize = 14;
  static const double listSummarySoilTemperatureFontSize = 25;
  static const double listSummaryTitleFontSize = 18;
  static const double listSummaryWeatherRangeFontSize = 16;
  static const double listSummaryWeatherTemperatureFontSize = 30;

  // opacity
  static const double opacityTextLabel = 0.7;
  static const double opacityTextBody = 0.85;
  static const double opacityTextHeadline = 1;

  // headline
  static const double headlineCurrentDurationFontSize = 18;

  // tooltip
  static const double tooltipFontSize = 14;
  static const double tooltipBorderRadius = 15;

  // page
  static const double pageAssistantSpacing = 10;
  static const double pageVentilationSpacing = 10;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 769;
  }
}
