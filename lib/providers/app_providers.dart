import 'package:provider/provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

List<ChangeNotifierProvider> get() {
  return [
    ChangeNotifierProvider<AppStationProvider>(
      create: (context) => AppStationProvider(),
    ),
    ChangeNotifierProvider<AppWeatherSingleDataProvider>(
      create: (context) => AppWeatherSingleDataProvider(),
    ),
  ];
}
