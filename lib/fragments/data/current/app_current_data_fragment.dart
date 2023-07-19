import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/data/current/app_soil_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/data/current/app_weather_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/fragments/text/app_current_duration_text_fragment.dart';
import 'package:weatherapp_ui/providers/data/single/app_single_data_provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_soil_single_data_provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

class AppCurrentDataFragment extends StatelessWidget {
  const AppCurrentDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStationProvider>(
      builder: (context, provider, widget) {
        AppStationResponseDto? station = provider.selectedStation;
        switch (station?.type) {
          case AppStationTypeEnum.WEATHER:
            return _rootWeather(context, station);
          case AppStationTypeEnum.SOIL:
            return _rootSoil(context, station);
          default:
            return Container();
        }
      },
    );
  }

  Widget _rootWeather(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppWeatherSingleDataProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);
    return Consumer<AppWeatherSingleDataProvider>(
      builder: (context, provider, widget) {
        return _display(
            provider,
            (p) => AppWeatherCurrentDataDisplayFragment(
                  weather: p.latest,
                ));
      },
    );
  }

  Widget _rootSoil(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppSoilSingleDataProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);
    return Consumer<AppSoilSingleDataProvider>(
      builder: (context, provider, widget) {
        return _display(
            provider,
            (p) => AppSoilCurrentDataDisplayFragment(
                  soil: p.latest,
                ));
      },
    );
  }

  Widget _display(AppSingleDataProvider provider,
      Widget Function(AppSingleDataProvider) widget) {
    return provider.loading
        ? const Center(
            child: AppLoadingFragment(
              size: 50,
            ),
          )
        : Column(
            children: [
              AppCurrentDurationTextFragment(
                  timestamp: provider.latest?.timestamp),
              Expanded(
                child: Center(child: widget.call(provider)),
              ),
            ],
          );
  }
}
