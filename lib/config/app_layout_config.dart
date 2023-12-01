import 'package:flutter/material.dart';

class AppLayoutConfig {
  // === DEFAULT VALUES ===
  static const double defaultBorderRadius = 15;
  static const double defaultButtonSize = 45;
  static const double defaultInputBorderWidth = 1;
  static const double defaultInputSize = 45;
  static const double defaultMaxWidth = 750;
  static const double defaultSpacing = 10;
  static const double defaultTextBodyFontSize = 16;
  static const double defaultTextLabelFontSize = 14;
  static const double defaultTextHeadlineFontSize = 18;

  // === CUSTOM VALUES ===
  // button
  static const double buttonReviewFilterSize = 32;
  static const double buttonPickerClearSize = 32;

  // chat
  static const double chatAssistantWeatherTimeMaxWidth = 220;

  // dialog
  static const double dialogAssistantDisclaimerHeight = 400;
  static const double dialogAssistantDisclaimerWidth = 350;
  static const double dialogMaxWidth = 500;
  static const double dialogTitleFontSize = 20;

  // icon
  static const double iconAssistantIntroSize = 60;

  // list
  static const double listSummarySoilTemperatureFontSize = 25;
  static const double listSummaryWeatherTemperatureFontSize = 30;

  // opacity
  static const double opacityTextLabel = 0.8;
  static const double opacityTextBody = 0.9;
  static const double opacityTextHeadline = 1;

  // text
  static const double textAssistantIntroHeadlineFontSize = 22;
  static const double textAssistantIntroTextFontSize = 20;
  static const double textAssistantIntroTextMaxWidth = 300;
  static const double textAssistantMessageWeatherRecordValueFontSize = 22;
  static const double textInfoHeadlineFontSize = 26;

  // page
  static const double pageInfoContentMaxWidth = 400;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 769;
  }

  static Image getImageAsset(BuildContext context, String name) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    String mode;
    if (brightness == Brightness.dark) {
      mode = "dark";
    } else {
      mode = "light";
    }
    return Image.asset("assets/images/$name-$mode.png");
  }
}
