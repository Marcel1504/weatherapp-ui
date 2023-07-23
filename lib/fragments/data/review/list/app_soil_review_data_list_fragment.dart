import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/data/review/list/app_review_data_list_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/item/app_soil_review_data_list_item_fragment.dart';
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
              timeOutputPattern: "dd.MM.yyyy",
              onTap: () => _openDetailPage(d.day)),
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
              timeOutputPattern: "MMMM yyyy",
              onTap: () => _openDetailPage("${d.year}-${d.month}")),
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
              timeOutputPattern: "yyyy",
              onTap: () => _openDetailPage(d.year)),
          provider: provider,
          station: station,
        );
      },
    );
  }

  void _openDetailPage(String? time) {}
}
