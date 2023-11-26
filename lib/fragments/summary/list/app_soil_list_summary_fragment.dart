import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/summary/detail/app_soil_detail_summary_fragment.dart';
import 'package:weatherapp_ui/fragments/summary/list/app_list_summary_fragment.dart';
import 'package:weatherapp_ui/fragments/summary/list/item/app_soil_list_summary_item_fragment.dart';
import 'package:weatherapp_ui/pages/data/detail/app_detail_data_page.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/day/app_soil_day_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/month/app_soil_month_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/year/app_soil_year_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppSoilListSummaryFragment extends StatelessWidget {
  final AppStationResponseDto? station;
  final AppCalendarEnum? type;

  const AppSoilListSummaryFragment({super.key, this.station, this.type});

  @override
  Widget build(BuildContext context) {
    return _root();
  }

  Widget _root() {
    switch (type) {
      case AppCalendarEnum.DAY:
        return _rootDay();
      case AppCalendarEnum.MONTH:
        return _rootMonth();
      case AppCalendarEnum.YEAR:
        return _rootYear();
      default:
        return Container();
    }
  }

  Widget _rootDay() {
    return Consumer<AppSoilDayAggregationSummaryProvider>(
      builder: (context, provider, widget) {
        return AppListSummaryFragment(
          itemBuilder: (d) => AppSoilListSummaryItemFragment(
              data: d,
              time: d.day,
              timeInputPattern: AppTimeService.isoDayPattern,
              timeOutputPattern: AppTimeService.prettyDayPattern,
              onTap: () => _openDetailPage(context, d.day, AppCalendarEnum.DAY)),
          provider: provider,
          station: station,
        );
      },
    );
  }

  Widget _rootMonth() {
    return Consumer<AppSoilMonthAggregationSummaryProvider>(
      builder: (context, provider, widget) {
        return AppListSummaryFragment(
          itemBuilder: (d) => AppSoilListSummaryItemFragment(
              data: d,
              time: "${d.year}-${d.month}",
              timeInputPattern: AppTimeService.isoMonthPattern,
              timeOutputPattern: AppTimeService.prettyMonthPattern,
              onTap: () => _openDetailPage(context, "${d.year}-${d.month}", AppCalendarEnum.MONTH)),
          provider: provider,
          station: station,
        );
      },
    );
  }

  Widget _rootYear() {
    return Consumer<AppSoilYearAggregationSummaryProvider>(
      builder: (context, provider, widget) {
        return AppListSummaryFragment(
          itemBuilder: (d) => AppSoilListSummaryItemFragment(
              data: d,
              time: d.year,
              timeInputPattern: AppTimeService.isoYearPattern,
              timeOutputPattern: AppTimeService.prettyYearPattern,
              onTap: () => _openDetailPage(context, d.year, AppCalendarEnum.YEAR)),
          provider: provider,
          station: station,
        );
      },
    );
  }

  void _openDetailPage(BuildContext context, String? time, AppCalendarEnum type) {
    if (type == AppCalendarEnum.DAY) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(AppL18nConfig.get(context).chart_no_data_soil_day)));
      return;
    }
    AppTimeService timeService = AppTimeService();
    String? title = timeService.transformTimeString(context, time,
        inputPattern: timeService.getIsoPatternForCalendarEnum(type)!,
        outputPattern: timeService.getPrettyPatternForCalendarEnum(type)!);
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => AppDetailDataPage(
              title: title,
              child: AppSoilDetailSummaryFragment(
                time: time,
                type: type,
              )),
        ));
  }
}
