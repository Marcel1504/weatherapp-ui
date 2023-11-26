import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/providers/assistant/app_assistant_provider.dart';
import 'package:weatherapp_ui/providers/export/app_soil_export_provider.dart';
import 'package:weatherapp_ui/providers/export/app_weather_export_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/day/app_soil_day_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/day/app_weather_day_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/month/app_soil_month_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/month/app_weather_month_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/year/app_soil_year_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/year/app_weather_year_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/detail/app_soil_detail_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/detail/app_weather_detail_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/single/app_soil_single_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/single/app_weather_single_summary_provider.dart';
import 'package:weatherapp_ui/providers/ventilation/app_ventilation_provider.dart';

class AppProvider {
  List<ChangeNotifierProvider> get() {
    return [
      ChangeNotifierProvider<AppStationProvider>(
        create: (context) => AppStationProvider(),
      ),
      ChangeNotifierProvider<AppVentilationProvider>(
        create: (context) => AppVentilationProvider(),
      ),
      ChangeNotifierProvider<AppAssistantProvider>(
        create: (context) => AppAssistantProvider(),
      ),

      // Weather
      ChangeNotifierProvider<AppWeatherSingleSummaryProvider>(
        create: (context) => AppWeatherSingleSummaryProvider(),
      ),
      ChangeNotifierProvider<AppWeatherDayAggregationSummaryProvider>(
        create: (context) => AppWeatherDayAggregationSummaryProvider(),
      ),
      ChangeNotifierProvider<AppWeatherMonthAggregationSummaryProvider>(
        create: (context) => AppWeatherMonthAggregationSummaryProvider(),
      ),
      ChangeNotifierProvider<AppWeatherYearAggregationSummaryProvider>(
        create: (context) => AppWeatherYearAggregationSummaryProvider(),
      ),
      ChangeNotifierProvider<AppWeatherDetailSummaryProvider>(
        create: (context) => AppWeatherDetailSummaryProvider(),
      ),
      ChangeNotifierProvider<AppWeatherExportProvider>(
        create: (context) => AppWeatherExportProvider(),
      ),

      // Soil
      ChangeNotifierProvider<AppSoilSingleSummaryProvider>(
        create: (context) => AppSoilSingleSummaryProvider(),
      ),
      ChangeNotifierProvider<AppSoilDayAggregationSummaryProvider>(
        create: (context) => AppSoilDayAggregationSummaryProvider(),
      ),
      ChangeNotifierProvider<AppSoilMonthAggregationSummaryProvider>(
        create: (context) => AppSoilMonthAggregationSummaryProvider(),
      ),
      ChangeNotifierProvider<AppSoilYearAggregationSummaryProvider>(
        create: (context) => AppSoilYearAggregationSummaryProvider(),
      ),
      ChangeNotifierProvider<AppSoilDetailSummaryProvider>(
        create: (context) => AppSoilDetailSummaryProvider(),
      ),
      ChangeNotifierProvider<AppSoilExportProvider>(
        create: (context) => AppSoilExportProvider(),
      ),
    ];
  }

  void reset(BuildContext context) {
    // Weather
    Provider.of<AppWeatherSingleSummaryProvider>(context, listen: false).markForReset();
    Provider.of<AppWeatherDayAggregationSummaryProvider>(context, listen: false).markForReset();
    Provider.of<AppWeatherMonthAggregationSummaryProvider>(context, listen: false).markForReset();
    Provider.of<AppWeatherYearAggregationSummaryProvider>(context, listen: false).markForReset();

    // Soil
    Provider.of<AppSoilSingleSummaryProvider>(context, listen: false).markForReset();
    Provider.of<AppSoilDayAggregationSummaryProvider>(context, listen: false).markForReset();
    Provider.of<AppSoilMonthAggregationSummaryProvider>(context, listen: false).markForReset();
    Provider.of<AppSoilYearAggregationSummaryProvider>(context, listen: false).markForReset();
  }
}
