import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/dto/response/data/single/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppWeatherCurrentDataRainFragment extends StatelessWidget {
  final AppWeatherSingleDataResponseDto? weather;

  const AppWeatherCurrentDataRainFragment({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    String? duration = AppTimeService()
        .transformISODateTimeStringToCurrentDuration(
            context, weather?.timestamp);
    AppLayoutService layoutService = AppLayoutService();
    return duration != null
        ? Padding(
            padding: EdgeInsets.only(
                bottom: layoutService.betweenItemPadding() * 3,
                top: layoutService.betweenItemPadding() * 3),
            child: Text(
              AppLocalizations.of(context)!.weather_current_duration(duration),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : Container();
  }
}
