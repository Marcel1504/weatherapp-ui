import 'package:flutter/material.dart';

class AppLayoutConfig {
  // button
  static const double buttonDefaultSize = 35;

  // chat
  static const double chatMessageBorderRadius = 15;
  static const double chatMessageContentSpacing = 10;
  static const double chatMessageFontSize = 18;
  static const double chatMessageSpacing = 10;

  // font
  static const double fontOpacityLow = 0.7;
  static const double fontOpacityMedium = 0.85;
  static const double fontOpacityHigh = 1;

  // input
  static const double inputBorderDefaultWidth = 1;
  static const double inputDefaultSize = 50;

  // tooltip
  static const double tooltipFontSize = 14;
  static const double tooltipBorderRadius = 15;

  // page
  static const double pageAssistantSpacing = 10;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 769;
  }
}
