import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/dto/response/data/single/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/fragments/text/app_icon_text_fragment.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppWeatherCurrentDataRainFragment extends StatelessWidget {
  final AppWeatherSingleDataResponseDto? weather;

  const AppWeatherCurrentDataRainFragment({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();
    AppTimeService timeService = AppTimeService();
    Widget? rainInfo;
    if (weather?.rainRate != null && weather?.rainRate != 0) {
      rainInfo = AppIconTextFragment(
        text: "${weather?.rainRate.toString()} mm/h",
        icon: Icons.cloudy_snowing,
        size: 25,
        color: Color.alphaBlend(const Color.fromRGBO(0, 175, 255, 0.7),
            Theme.of(context).colorScheme.onBackground),
      );
    } else if (weather?.lastRain != null) {
      String? duration =
          timeService.transformISODateTimeStringToCurrentDuration(
              context, weather?.lastRain);
      rainInfo = Text(
        duration != null
            ? AppLocalizations.of(context)!.weather_last_rain(duration)
            : AppLocalizations.of(context)!.weather_last_rain_unknown,
        style:
            layoutService.appTextStyle(context, color: "background", size: "m"),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: layoutService.betweenItemPadding() * 3),
      child: rainInfo ?? Container(),
    );
  }
}
