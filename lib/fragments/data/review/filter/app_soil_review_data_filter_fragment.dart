import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';
import 'package:weatherapp_ui/fragments/data/review/filter/header/app_review_data_filter_header_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/filter/picker/app_review_data_filter_datepicker_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/filter/picker/app_review_data_filter_yearpicker_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/filter/sort/app_review_data_filter_sort_fragment.dart';
import 'package:weatherapp_ui/fragments/dialog/app_dialog_fragment.dart';
import 'package:weatherapp_ui/models/app_soil_filter_model.dart';
import 'package:weatherapp_ui/providers/data/summary/app_summary_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/day/app_soil_day_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/month/app_soil_month_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/year/app_soil_year_data_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppSoilReviewDataFilterFragment extends StatefulWidget {
  final AppStationResponseDto? station;
  final AppCalendarEnum? type;

  const AppSoilReviewDataFilterFragment({super.key, this.type, this.station});

  @override
  State<AppSoilReviewDataFilterFragment> createState() =>
      _AppSoilReviewDataFilterFragmentState();
}

class _AppSoilReviewDataFilterFragmentState
    extends State<AppSoilReviewDataFilterFragment> {
  AppSoilFilterModel? _filter;
  AppSummaryDataProvider? _provider;
  String? _title;

  @override
  Widget build(BuildContext context) {
    Widget root = _filterRoot();
    return AppDialogFragment(
      title: _title,
      child: root,
      onAccept: () {
        _provider?.setFilter(filter: _filter);
        _provider?.loadInitialByStationCode(widget.station?.code,
            notifyLoadStart: true);
      },
    );
  }

  Widget _filterRoot() {
    switch (widget.type) {
      case AppCalendarEnum.DAY:
        return _dayFilter();
      case AppCalendarEnum.MONTH:
        return _monthFilter();
      case AppCalendarEnum.YEAR:
        return _yearFilter();
      default:
        return Container();
    }
  }

  Widget _dayFilter() {
    _title = AppLocalizations.of(context)!.filter_title_day;
    return Consumer<AppSoilDayDataProvider>(
        builder: (context, provider, widget) {
      _initializeProviderAndFilterModel(provider);
      return ListView(
        children: [
          AppReviewDataFilterHeaderFragment(
              title: AppLocalizations.of(context)!.filter_title_limitation),
          AppReviewDataFilterDatePickerFragment(
            title: AppLocalizations.of(context)!.filter_value_start_day,
            initialDate: AppTimeService().parseDayString(_filter?.startDay),
            onSelected: (d) => setState(() => _filter?.startDay =
                AppTimeService().transformDateTime(context, d,
                    pattern: AppTimeService.isoDayPattern)),
          ),
          const Divider(),
          AppReviewDataFilterDatePickerFragment(
            title: AppLocalizations.of(context)!.filter_value_end_day,
            initialDate: AppTimeService().parseDayString(_filter?.endDay),
            onSelected: (d) => setState(() => _filter?.endDay = AppTimeService()
                .transformDateTime(context, d,
                    pattern: AppTimeService.isoDayPattern)),
          ),
          AppReviewDataFilterHeaderFragment(
              title: AppLocalizations.of(context)!.filter_title_sort),
          ..._sortList()
        ],
      );
    });
  }

  Widget _monthFilter() {
    _title = AppLocalizations.of(context)!.filter_title_month;
    return Consumer<AppSoilMonthDataProvider>(
        builder: (context, provider, widget) {
      _initializeProviderAndFilterModel(provider);
      return ListView(
        children: [
          AppReviewDataFilterHeaderFragment(
              title: AppLocalizations.of(context)!.filter_title_limitation),
          AppReviewDataFilterYearPickerFragment(
              initialYear: AppTimeService().parseTimeString(_filter?.year,
                  pattern: AppTimeService.isoYearPattern),
              onSelected: (d) => setState(() => _filter?.year = AppTimeService()
                  .transformDateTime(context, d,
                      pattern: AppTimeService.isoYearPattern))),
          AppReviewDataFilterHeaderFragment(
              title: AppLocalizations.of(context)!.filter_title_sort),
          ..._sortList()
        ],
      );
    });
  }

  Widget _yearFilter() {
    _title = AppLocalizations.of(context)!.filter_title_year;
    return Consumer<AppSoilYearDataProvider>(
        builder: (context, provider, widget) {
      _initializeProviderAndFilterModel(provider);
      return ListView(children: [
        AppReviewDataFilterHeaderFragment(
            title: AppLocalizations.of(context)!.filter_title_sort),
        ..._sortList()
      ]);
    });
  }

  List<Widget> _sortList() {
    List<MapEntry<AppSoilSortEnum, String>> list = _getSorts().entries.toList();
    return list
        .mapIndexed((index, s) => Column(
              children: [
                AppReviewDataFilterSortFragment(
                  title: list[index].value,
                  selected: list[index].key == _filter?.sort,
                  icon: list[index].key.getFilterIcon(),
                  onTap: () => setState(() => _filter?.sort = list[index].key),
                ),
                index == list.length - 1 ? Container() : const Divider()
              ],
            ))
        .toList();
  }

  Map<AppSoilSortEnum, String> _getSorts() {
    return {
      AppSoilSortEnum.LATEST: AppLocalizations.of(context)!.sort_latest,
      AppSoilSortEnum.OLDEST: AppLocalizations.of(context)!.sort_oldest,
      AppSoilSortEnum.HIGHEST_TEMPERATURE50CM:
          AppLocalizations.of(context)!.sort_temperature_50cm_highest,
      AppSoilSortEnum.LOWEST_TEMPERATURE50CM:
          AppLocalizations.of(context)!.sort_temperature_50cm_lowest,
      AppSoilSortEnum.HIGHEST_TEMPERATURE100CM:
          AppLocalizations.of(context)!.sort_temperature_100cm_highest,
      AppSoilSortEnum.LOWEST_TEMPERATURE100CM:
          AppLocalizations.of(context)!.sort_temperature_100cm_lowest,
      AppSoilSortEnum.HIGHEST_TEMPERATURE200CM:
          AppLocalizations.of(context)!.sort_temperature_200cm_highest,
      AppSoilSortEnum.LOWEST_TEMPERATURE200CM:
          AppLocalizations.of(context)!.sort_temperature_200cm_lowest,
    };
  }

  void _initializeProviderAndFilterModel(AppSummaryDataProvider provider) {
    _provider = provider;
    _filter ??= AppSoilFilterModel(
        sort: _provider?.filter?.sort ?? AppSoilSortEnum.LATEST,
        startDay: _provider?.filter?.startDay,
        endDay: _provider?.filter?.endDay,
        year: _provider?.filter?.year);
  }
}
