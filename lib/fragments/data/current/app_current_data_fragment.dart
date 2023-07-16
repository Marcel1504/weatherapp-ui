import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/data/current/app_weather_current_data_fragment.dart';
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
            return AppWeatherCurrentDataFragment(station: station);
          case AppStationTypeEnum.SOIL:
          default:
            return Container();
        }
      },
    );
  }
}
