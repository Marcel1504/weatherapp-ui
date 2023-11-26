import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/chart/app_line_chart_component.dart';
import 'package:weatherapp_ui/components/loading/app_loading_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/summary/detail/app_detail_summary_fragment.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/providers/summary/detail/app_soil_detail_summary_provider.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppSoilDetailSummaryFragment extends StatefulWidget {
  final String? time;
  final AppCalendarEnum type;

  const AppSoilDetailSummaryFragment({super.key, this.time, required this.type});

  @override
  State<AppSoilDetailSummaryFragment> createState() => _AppSoilDetailSummaryFragmentState();
}

class _AppSoilDetailSummaryFragmentState extends State<AppSoilDetailSummaryFragment> {
  List<String> timeLabelsISO = [];
  List<String> timeLabelsPretty = [];

  @override
  void initState() {
    super.initState();
    String? stationCode = Provider.of<AppStationProvider>(context, listen: false).selectedStation?.code;
    Provider.of<AppSoilDetailSummaryProvider>(context, listen: false)
        .loadDetailsByStationCode(stationCode, widget.time, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSoilDetailSummaryProvider>(
      builder: (context, provider, widget) {
        _setTimeLabels(provider);
        return !provider.loading
            ? AppDetailSummaryFragment(chartTitles: [
                AppL18nConfig.get(context).chart_unit_soil_avg,
                AppL18nConfig.get(context).chart_unit_soil_max,
                AppL18nConfig.get(context).chart_unit_soil_min,
              ], chartWidgets: [
                _getTemperatureAvgChart(context, provider),
                _getTemperatureMaxChart(context, provider),
                _getTemperatureMinChart(context, provider),
              ])
            : const Center(
                child: AppLoadingComponent(
                  size: 30,
                ),
              );
      },
    );
  }

  Widget _getTemperatureAvgChart(BuildContext context, AppSoilDetailSummaryProvider provider) {
    return AppLineChartComponent(
      key: const ValueKey(1),
      valueUnit: "°C",
      labels: timeLabelsPretty,
      valueLists: [
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature50cmAvg),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature100cmAvg),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature200cmAvg),
      ],
      valueTitles: [
        AppL18nConfig.get(context).chart_title_soil_50cm,
        AppL18nConfig.get(context).chart_title_soil_100cm,
        AppL18nConfig.get(context).chart_title_soil_200cm,
      ],
      noDataText: AppL18nConfig.get(context).chart_no_data_temperature,
      lineGradient: (context, list) => AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getTemperatureMaxChart(BuildContext context, AppSoilDetailSummaryProvider provider) {
    return AppLineChartComponent(
      key: const ValueKey(2),
      valueUnit: "°C",
      labels: timeLabelsPretty,
      valueLists: [
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature50cmMax),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature100cmMax),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature200cmMax),
      ],
      valueTitles: [
        AppL18nConfig.get(context).chart_title_soil_50cm,
        AppL18nConfig.get(context).chart_title_soil_100cm,
        AppL18nConfig.get(context).chart_title_soil_200cm,
      ],
      noDataText: AppL18nConfig.get(context).chart_no_data_temperature,
      lineGradient: (context, list) => AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getTemperatureMinChart(BuildContext context, AppSoilDetailSummaryProvider provider) {
    return AppLineChartComponent(
      key: const ValueKey(3),
      valueUnit: "°C",
      labels: timeLabelsPretty,
      valueLists: [
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature50cmMin),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature100cmMin),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature200cmMin),
      ],
      valueTitles: [
        AppL18nConfig.get(context).chart_title_soil_50cm,
        AppL18nConfig.get(context).chart_title_soil_100cm,
        AppL18nConfig.get(context).chart_title_soil_200cm,
      ],
      noDataText: AppL18nConfig.get(context).chart_no_data_temperature,
      lineGradient: (context, list) => AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  void _setTimeLabels(AppSoilDetailSummaryProvider provider) {
    AppTimeService timeService = AppTimeService();
    switch (widget.type) {
      case AppCalendarEnum.DAY:
        timeLabelsISO = timeService.getISOHoursOfDay();
        timeLabelsPretty = timeLabelsISO
            .map(
                (t) => timeService.transformTimeString(context, t, inputPattern: "HH", outputPattern: "HH:'00'") ?? "?")
            .toList();
        break;
      case AppCalendarEnum.MONTH:
        timeLabelsISO = timeService.getISODaysOfMonth(provider.time!.substring(0, 4), provider.time!.substring(5, 7));
        timeLabelsPretty = timeLabelsISO
            .map((t) =>
                timeService.transformTimeString(context, t, inputPattern: "yyyy-MM-dd", outputPattern: "dd.MM") ?? "?")
            .toList();
        break;
      case AppCalendarEnum.YEAR:
        timeLabelsISO = timeService.getISOMonthsOfYear();
        timeLabelsPretty = timeLabelsISO
            .map((t) => timeService.transformTimeString(context, t, inputPattern: "MM", outputPattern: "MMM") ?? "?")
            .toList();
        break;
    }
  }

  List<double?> _valuesFilledForTimeLabels(
      AppSoilDetailSummaryProvider provider, double? Function(AppSoilAggregationSummaryResponseDto?) map) {
    return timeLabelsISO
        .map((t) {
          switch (widget.type) {
            case AppCalendarEnum.DAY:
              return null;
            case AppCalendarEnum.MONTH:
              return provider.data.firstWhereOrNull((d) => d.day == t);
            case AppCalendarEnum.YEAR:
              return provider.data.firstWhereOrNull((d) => d.month == t);
          }
        })
        .map((d) => map.call(d))
        .toList();
  }
}
