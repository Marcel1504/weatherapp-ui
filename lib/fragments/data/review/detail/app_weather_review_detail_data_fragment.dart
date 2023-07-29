import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/data/review/detail/app_review_detail_data_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/detail/charts/app_review_detail_data_rain_chart_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/detail/charts/app_review_detail_temperature_chart_fragment.dart';
import 'package:weatherapp_ui/providers/data/detail/app_weather_detail_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppWeatherReviewDetailDataFragment extends StatefulWidget {
  final String? time;
  final AppCalendarEnum type;

  const AppWeatherReviewDetailDataFragment(
      {super.key, this.time, required this.type});

  @override
  State<AppWeatherReviewDetailDataFragment> createState() =>
      _AppWeatherReviewDetailDataFragmentState();
}

class _AppWeatherReviewDetailDataFragmentState
    extends State<AppWeatherReviewDetailDataFragment> {
  @override
  void initState() {
    super.initState();
    String? stationCode =
        Provider.of<AppStationProvider>(context, listen: false)
            .selectedStation
            ?.code;
    Provider.of<AppWeatherDetailDataProvider>(context, listen: false)
        .loadDetailsByStationCode(stationCode, widget.time, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppWeatherDetailDataProvider>(
      builder: (context, provider, widget) {
        return AppReviewDetailDataFragment(chartTitles: [
          "Temperatur",
          "Regen"
        ], chartWidgets: [
          _getTemperatureChart(context, provider),
          _getRainChart(context, provider)
        ]);
      },
    );
  }

  Widget _getTemperatureChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppReviewDetailTemperatureChartFragment(
      temperatureListTitles: ["max.", "min."],
      timeLabels: _timeLabels(provider),
      temperatureLists: [
        provider.data.map((d) => d.temperatureMax).toList(),
        provider.data.map((d) => d.temperatureMin).toList(),
      ],
    );
  }

  Widget _getRainChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppReviewDetailDataRainChartFragment(
      rain: provider.data.map((d) => d.rainTotal ?? 0).toList(),
      timeLabels: _timeLabels(provider),
    );
  }

  List<String> _timeLabels(AppWeatherDetailDataProvider provider) {
    return provider.data.map((d) {
      AppTimeService timeService = AppTimeService();
      String? time;
      switch (widget.type) {
        case AppCalendarEnum.DAY:
          time = timeService.transformTimeString(context, d.hour,
              inputPattern: "HH", outputPattern: "HH:'00'");
          break;
        case AppCalendarEnum.MONTH:
          time = timeService.transformTimeString(context, d.day,
              inputPattern: "yyyy-MM-dd", outputPattern: "dd.MM");
          break;
        case AppCalendarEnum.YEAR:
          time = timeService.transformTimeString(context, d.month,
              inputPattern: "MM", outputPattern: "MMM");
          break;
      }
      return time ?? "?";
    }).toList();
  }
}
