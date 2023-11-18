import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/chart/app_line_chart_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/detail/app_review_detail_data_fragment.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/providers/data/detail/app_soil_detail_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppSoilReviewDetailDataFragment extends StatefulWidget {
  final String? time;
  final AppCalendarEnum type;

  const AppSoilReviewDetailDataFragment({super.key, this.time, required this.type});

  @override
  State<AppSoilReviewDetailDataFragment> createState() => _AppSoilReviewDetailDataFragmentState();
}

class _AppSoilReviewDetailDataFragmentState extends State<AppSoilReviewDetailDataFragment> {
  List<String> timeLabelsISO = [];
  List<String> timeLabelsPretty = [];

  @override
  void initState() {
    super.initState();
    String? stationCode = Provider.of<AppStationProvider>(context, listen: false).selectedStation?.code;
    Provider.of<AppSoilDetailDataProvider>(context, listen: false)
        .loadDetailsByStationCode(stationCode, widget.time, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSoilDetailDataProvider>(
      builder: (context, provider, widget) {
        _setTimeLabels(provider);
        return !provider.loading
            ? AppReviewDetailDataFragment(chartTitles: [
                AppLocalizations.of(context)!.chart_unit_soil_avg,
                AppLocalizations.of(context)!.chart_unit_soil_max,
                AppLocalizations.of(context)!.chart_unit_soil_min,
              ], chartWidgets: [
                _getTemperatureAvgChart(context, provider),
                _getTemperatureMaxChart(context, provider),
                _getTemperatureMinChart(context, provider),
              ])
            : const Center(
                child: AppLoadingFragment(
                  size: 30,
                ),
              );
      },
    );
  }

  Widget _getTemperatureAvgChart(BuildContext context, AppSoilDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(1),
      valueUnit: "°C",
      labels: timeLabelsPretty,
      valueLists: [
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature50cmAvg),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature100cmAvg),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature200cmAvg),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_title_soil_50cm,
        AppLocalizations.of(context)!.chart_title_soil_100cm,
        AppLocalizations.of(context)!.chart_title_soil_200cm,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) => AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getTemperatureMaxChart(BuildContext context, AppSoilDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(2),
      valueUnit: "°C",
      labels: timeLabelsPretty,
      valueLists: [
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature50cmMax),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature100cmMax),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature200cmMax),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_title_soil_50cm,
        AppLocalizations.of(context)!.chart_title_soil_100cm,
        AppLocalizations.of(context)!.chart_title_soil_200cm,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) => AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getTemperatureMinChart(BuildContext context, AppSoilDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(3),
      valueUnit: "°C",
      labels: timeLabelsPretty,
      valueLists: [
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature50cmMin),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature100cmMin),
        _valuesFilledForTimeLabels(provider, (d) => d?.temperature200cmMin),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_title_soil_50cm,
        AppLocalizations.of(context)!.chart_title_soil_100cm,
        AppLocalizations.of(context)!.chart_title_soil_200cm,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) => AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  void _setTimeLabels(AppSoilDetailDataProvider provider) {
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
      AppSoilDetailDataProvider provider, double? Function(AppSoilSummaryDataResponseDto?) map) {
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
