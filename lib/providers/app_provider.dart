import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_soil_single_data_provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/day/app_soil_day_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/day/app_weather_day_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/month/app_soil_month_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/month/app_weather_month_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/year/app_soil_year_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/year/app_weather_year_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

class AppProvider {
  List<ChangeNotifierProvider> get() {
    return [
      ChangeNotifierProvider<AppStationProvider>(
        create: (context) => AppStationProvider(),
      ),

      // Weather
      ChangeNotifierProvider<AppWeatherSingleDataProvider>(
        create: (context) => AppWeatherSingleDataProvider(),
      ),
      ChangeNotifierProvider<AppWeatherDayDataProvider>(
        create: (context) => AppWeatherDayDataProvider(),
      ),
      ChangeNotifierProvider<AppWeatherMonthDataProvider>(
        create: (context) => AppWeatherMonthDataProvider(),
      ),
      ChangeNotifierProvider<AppWeatherYearDataProvider>(
        create: (context) => AppWeatherYearDataProvider(),
      ),

      // Soil
      ChangeNotifierProvider<AppSoilSingleDataProvider>(
        create: (context) => AppSoilSingleDataProvider(),
      ),
      ChangeNotifierProvider<AppSoilDayDataProvider>(
        create: (context) => AppSoilDayDataProvider(),
      ),
      ChangeNotifierProvider<AppSoilMonthDataProvider>(
        create: (context) => AppSoilMonthDataProvider(),
      ),
      ChangeNotifierProvider<AppSoilYearDataProvider>(
        create: (context) => AppSoilYearDataProvider(),
      ),
    ];
  }

  void reset(BuildContext context) {
    // Weather
    Provider.of<AppWeatherSingleDataProvider>(context, listen: false)
        .markForReset();
    Provider.of<AppWeatherDayDataProvider>(context, listen: false)
        .markForReset();
    Provider.of<AppWeatherMonthDataProvider>(context, listen: false)
        .markForReset();
    Provider.of<AppWeatherYearDataProvider>(context, listen: false)
        .markForReset();

    // Soil
    Provider.of<AppSoilSingleDataProvider>(context, listen: false)
        .markForReset();
    Provider.of<AppSoilDayDataProvider>(context, listen: false).markForReset();
    Provider.of<AppSoilMonthDataProvider>(context, listen: false)
        .markForReset();
    Provider.of<AppSoilYearDataProvider>(context, listen: false).markForReset();
  }
}
