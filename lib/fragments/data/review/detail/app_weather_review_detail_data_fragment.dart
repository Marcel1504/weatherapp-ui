import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/chart/app_bar_chart_fragment.dart';
import 'package:weatherapp_ui/fragments/chart/app_line_chart_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/detail/app_review_detail_data_fragment.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/providers/data/detail/app_weather_detail_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
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
        return !provider.loading
            ? AppReviewDetailDataFragment(chartTitles: [
                AppLocalizations.of(context)!.chart_title_temperature,
                AppLocalizations.of(context)!.chart_title_rain,
                AppLocalizations.of(context)!.chart_title_humidity,
                AppLocalizations.of(context)!.chart_title_pressure,
                AppLocalizations.of(context)!.chart_title_wind,
                AppLocalizations.of(context)!.chart_title_solar_radiation,
              ], chartWidgets: [
                _getTemperatureChart(context, provider),
                _getRainChart(context, provider),
                _getHumidityChart(context, provider),
                _getPressureChart(context, provider),
                _getWindChart(context, provider),
                _getSolarRadiationChart(context, provider)
              ])
            : const Center(
                child: AppLoadingFragment(
                  size: 30,
                ),
              );
      },
    );
  }

  Widget _getTemperatureChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(1),
      valueUnit: "°C",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.temperatureAvg).toList(),
        provider.data.map((d) => d.temperatureMax).toList(),
        provider.data.map((d) => d.temperatureMin).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_unit_avg,
        AppLocalizations.of(context)!.chart_unit_max,
        AppLocalizations.of(context)!.chart_unit_min
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) =>
          AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getRainChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppBarChartFragment(
      labels: _timeLabels(provider),
      values: provider.data.map((d) => d.rainTotal ?? 0).toList(),
      valueUnit: "l/m²",
      noDataText: AppLocalizations.of(context)!.chart_no_data_rain,
      barGradient: (context, value, maxValue) => AppColorService()
          .valueLinearGradient(context, value, 0, maxValue,
              const Color.fromRGBO(0, 175, 255, 1)),
    );
  }

  Widget _getHumidityChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(2),
      valueUnit: "%",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.humidityAvg).toList(),
        provider.data.map((d) => d.humidityMax?.toDouble()).toList(),
        provider.data.map((d) => d.humidityMin?.toDouble()).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_unit_avg,
        AppLocalizations.of(context)!.chart_unit_max,
        AppLocalizations.of(context)!.chart_unit_min
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_humidity,
      lineGradient: (context, list) => AppColorService()
          .valueListLinearGradient(context, list, 20, 100, Colors.purple),
    );
  }

  Widget _getPressureChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(3),
      valueUnit: "hpa",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.pressureAvg).toList(),
        provider.data.map((d) => d.pressureMax).toList(),
        provider.data.map((d) => d.pressureMin).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_unit_avg,
        AppLocalizations.of(context)!.chart_unit_max,
        AppLocalizations.of(context)!.chart_unit_min
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_pressure,
      lineGradient: (context, list) => AppColorService()
          .valueListLinearGradient(context, list, 950, 1050, Colors.lightBlue),
    );
  }

  Widget _getWindChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(4),
      valueUnit: "km/h",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.windMax).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_unit_max,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_wind,
      lineGradient: (context, list) => AppColorService()
          .valueListLinearGradient(context, list, 0, 40, Colors.red),
    );
  }

  Widget _getSolarRadiationChart(
      BuildContext context, AppWeatherDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(5),
      valueUnit: "w/m²",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.solarRadiationAvg).toList(),
        provider.data.map((d) => d.solarRadiationMax).toList(),
        provider.data.map((d) => d.solarRadiationMin).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_unit_avg,
        AppLocalizations.of(context)!.chart_unit_max,
        AppLocalizations.of(context)!.chart_unit_min,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_solar_radiation,
      lineGradient: (context, list) => AppColorService()
          .valueListLinearGradient(context, list, 0, 1000, Colors.orange),
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
