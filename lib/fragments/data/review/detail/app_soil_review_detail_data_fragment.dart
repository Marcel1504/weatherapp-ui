import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
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

  const AppSoilReviewDetailDataFragment(
      {super.key, this.time, required this.type});

  @override
  State<AppSoilReviewDetailDataFragment> createState() =>
      _AppSoilReviewDetailDataFragmentState();
}

class _AppSoilReviewDetailDataFragmentState
    extends State<AppSoilReviewDetailDataFragment> {
  @override
  void initState() {
    super.initState();
    String? stationCode =
        Provider.of<AppStationProvider>(context, listen: false)
            .selectedStation
            ?.code;
    Provider.of<AppSoilDetailDataProvider>(context, listen: false)
        .loadDetailsByStationCode(stationCode, widget.time, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSoilDetailDataProvider>(
      builder: (context, provider, widget) {
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

  Widget _getTemperatureAvgChart(
      BuildContext context, AppSoilDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(1),
      valueUnit: "°C",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.temperature50cmAvg).toList(),
        provider.data.map((d) => d.temperature100cmAvg).toList(),
        provider.data.map((d) => d.temperature200cmAvg).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_title_soil_50cm,
        AppLocalizations.of(context)!.chart_title_soil_100cm,
        AppLocalizations.of(context)!.chart_title_soil_200cm,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) =>
          AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getTemperatureMaxChart(
      BuildContext context, AppSoilDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(2),
      valueUnit: "°C",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.temperature50cmMax).toList(),
        provider.data.map((d) => d.temperature100cmMax).toList(),
        provider.data.map((d) => d.temperature200cmMax).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_title_soil_50cm,
        AppLocalizations.of(context)!.chart_title_soil_100cm,
        AppLocalizations.of(context)!.chart_title_soil_200cm,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) =>
          AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  Widget _getTemperatureMinChart(
      BuildContext context, AppSoilDetailDataProvider provider) {
    return AppLineChartFragment(
      key: const ValueKey(3),
      valueUnit: "°C",
      labels: _timeLabels(provider),
      valueLists: [
        provider.data.map((d) => d.temperature50cmMin).toList(),
        provider.data.map((d) => d.temperature100cmMin).toList(),
        provider.data.map((d) => d.temperature200cmMin).toList(),
      ],
      valueTitles: [
        AppLocalizations.of(context)!.chart_title_soil_50cm,
        AppLocalizations.of(context)!.chart_title_soil_100cm,
        AppLocalizations.of(context)!.chart_title_soil_200cm,
      ],
      noDataText: AppLocalizations.of(context)!.chart_no_data_temperature,
      lineGradient: (context, list) =>
          AppColorService().temperaturesLinearGradient(context, list, 10),
    );
  }

  List<String> _timeLabels(AppSoilDetailDataProvider provider) {
    return provider.data.map((d) {
      AppTimeService timeService = AppTimeService();
      String? time;
      switch (widget.type) {
        case AppCalendarEnum.DAY:
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
