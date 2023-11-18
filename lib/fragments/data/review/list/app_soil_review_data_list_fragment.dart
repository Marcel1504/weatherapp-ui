import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/data/review/detail/app_soil_review_detail_data_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/app_review_data_list_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/item/app_soil_review_data_list_item_fragment.dart';
import 'package:weatherapp_ui/pages/data/detail/app_detail_data_page.dart';
import 'package:weatherapp_ui/providers/data/summary/day/app_soil_day_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/month/app_soil_month_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/year/app_soil_year_data_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppSoilReviewDataListFragment extends StatelessWidget {
  final AppStationResponseDto? station;
  final AppCalendarEnum? type;

  const AppSoilReviewDataListFragment({super.key, this.station, this.type});

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
    return Consumer<AppSoilDayDataProvider>(
      builder: (context, provider, widget) {
        return AppReviewDataListFragment(
          itemBuilder: (d) => AppSoilReviewDataListItemFragment(
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
    return Consumer<AppSoilMonthDataProvider>(
      builder: (context, provider, widget) {
        return AppReviewDataListFragment(
          itemBuilder: (d) => AppSoilReviewDataListItemFragment(
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
    return Consumer<AppSoilYearDataProvider>(
      builder: (context, provider, widget) {
        return AppReviewDataListFragment(
          itemBuilder: (d) => AppSoilReviewDataListItemFragment(
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
          .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.chart_no_data_soil_day)));
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
              child: AppSoilReviewDetailDataFragment(
                time: time,
                type: type,
              )),
        ));
  }
}
