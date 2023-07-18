import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/fragments/data/current/weather/app_weather_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/data/current/weather/app_weather_current_data_duration_fragment.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';

class AppWeatherCurrentDataFragment extends StatelessWidget {
  final AppStationResponseDto? station;

  const AppWeatherCurrentDataFragment({super.key, this.station});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppWeatherSingleDataProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);

    return Consumer<AppWeatherSingleDataProvider>(
        builder: (context, provider, widget) {
          return _root(context, provider);
    });
  }

  Widget _root(BuildContext context, AppWeatherSingleDataProvider provider) {
    return provider.loading
        ? const Center(
            child: AppLoadingFragment(
              size: 50,
            ),
          )
        : Column(
            children: [
              AppWeatherCurrentDataRainFragment(weather: provider.latest),
              Expanded(
                child: Center(
                    child: AppWeatherCurrentDataDisplayFragment(
                        weather: provider.latest)),
              ),
            ],
          );
  }
}
