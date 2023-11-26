import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/dialog/app_dialog_component.dart';
import 'package:weatherapp_ui/components/picker/app_picker_day_component.dart';
import 'package:weatherapp_ui/components/picker/app_picker_year_component.dart';
import 'package:weatherapp_ui/components/text/app_header_text_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';
import 'package:weatherapp_ui/fragments/summary/filter/app_filter_summary_fragment.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/app_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/day/app_weather_day_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/month/app_weather_month_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/year/app_weather_year_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppWeatherFilterDialogComponent extends StatefulWidget {
  final AppStationResponseDto? station;
  final AppCalendarEnum? type;

  const AppWeatherFilterDialogComponent({super.key, this.type, this.station});

  @override
  State<AppWeatherFilterDialogComponent> createState() => _AppWeatherFilterDialogComponentState();
}

class _AppWeatherFilterDialogComponentState extends State<AppWeatherFilterDialogComponent> {
  AppWeatherFilterModel? _filter;
  AppAggregationSummaryProvider? _provider;
  String? _title;

  @override
  Widget build(BuildContext context) {
    Widget root = _filterRoot();
    return AppDialogComponent(
      title: _title,
      child: root,
      onAccept: () {
        _provider?.setFilter(filter: _filter);
        _provider?.loadInitialByStationCode(widget.station?.code, notifyLoadStart: true);
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
    _title = AppL18nConfig.get(context).filter_title_day;
    return Consumer<AppWeatherDayAggregationSummaryProvider>(builder: (context, provider, widget) {
      _initializeProviderAndFilterModel(provider);
      return ListView(
        children: [
          AppHeaderTextComponent(title: AppL18nConfig.get(context).filter_title_limitation),
          AppPickerDayComponent(
            title: AppL18nConfig.get(context).filter_value_start_day,
            initialDate: AppTimeService().parseDayString(_filter?.startDay),
            onSelected: (d) => setState(() => _filter?.startDay =
                AppTimeService().transformDateTime(context, d, pattern: AppTimeService.isoDayPattern)),
          ),
          const Divider(),
          AppPickerDayComponent(
            title: AppL18nConfig.get(context).filter_value_end_day,
            initialDate: AppTimeService().parseDayString(_filter?.endDay),
            onSelected: (d) => setState(() => _filter?.endDay =
                AppTimeService().transformDateTime(context, d, pattern: AppTimeService.isoDayPattern)),
          ),
          AppHeaderTextComponent(title: AppL18nConfig.get(context).filter_title_sort),
          ..._sortList()
        ],
      );
    });
  }

  Widget _monthFilter() {
    _title = AppL18nConfig.get(context).filter_title_month;
    return Consumer<AppWeatherMonthAggregationSummaryProvider>(builder: (context, provider, widget) {
      _initializeProviderAndFilterModel(provider);
      return ListView(
        children: [
          AppHeaderTextComponent(title: AppL18nConfig.get(context).filter_title_limitation),
          AppPickerYearComponent(
              initialYear: AppTimeService().parseTimeString(_filter?.year, pattern: AppTimeService.isoYearPattern),
              onSelected: (d) => setState(() => _filter?.year =
                  AppTimeService().transformDateTime(context, d, pattern: AppTimeService.isoYearPattern))),
          AppHeaderTextComponent(title: AppL18nConfig.get(context).filter_title_sort),
          ..._sortList()
        ],
      );
    });
  }

  Widget _yearFilter() {
    _title = AppL18nConfig.get(context).filter_title_year;
    return Consumer<AppWeatherYearAggregationSummaryProvider>(builder: (context, provider, widget) {
      _initializeProviderAndFilterModel(provider);
      return ListView(
          children: [AppHeaderTextComponent(title: AppL18nConfig.get(context).filter_title_sort), ..._sortList()]);
    });
  }

  List<Widget> _sortList() {
    List<MapEntry<AppWeatherSortEnum, String>> list = _getSorts().entries.toList();
    return list
        .mapIndexed((index, s) => Column(
              children: [
                AppFilterSummaryFragment(
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

  Map<AppWeatherSortEnum, String> _getSorts() {
    return {
      AppWeatherSortEnum.LATEST: AppL18nConfig.get(context).sort_latest,
      AppWeatherSortEnum.OLDEST: AppL18nConfig.get(context).sort_oldest,
      AppWeatherSortEnum.HIGHEST_TEMPERATURE: AppL18nConfig.get(context).sort_temperature_highest,
      AppWeatherSortEnum.LOWEST_TEMPERATURE: AppL18nConfig.get(context).sort_temperature_lowest,
      AppWeatherSortEnum.HIGHEST_HUMIDITY: AppL18nConfig.get(context).sort_humidity_highest,
      AppWeatherSortEnum.LOWEST_HUMIDITY: AppL18nConfig.get(context).sort_humidity_lowest,
      AppWeatherSortEnum.MOST_RAIN: AppL18nConfig.get(context).sort_rain_most,
      AppWeatherSortEnum.STRONGEST_WIND: AppL18nConfig.get(context).sort_wind_strongest,
      AppWeatherSortEnum.HIGHEST_PRESSURE: AppL18nConfig.get(context).sort_pressure_highest,
      AppWeatherSortEnum.LOWEST_PRESSURE: AppL18nConfig.get(context).sort_pressure_lowest,
      AppWeatherSortEnum.HIGHEST_SOLAR_RADIATION: AppL18nConfig.get(context).sort_solar_radiation_highest,
      AppWeatherSortEnum.LOWEST_SOLAR_RADIATION: AppL18nConfig.get(context).sort_solar_radiation_lowest,
    };
  }

  void _initializeProviderAndFilterModel(AppAggregationSummaryProvider provider) {
    _provider = provider;
    _filter ??= AppWeatherFilterModel(
        sort: _provider?.filter?.sort ?? AppWeatherSortEnum.LATEST,
        startDay: _provider?.filter?.startDay,
        endDay: _provider?.filter?.endDay,
        year: _provider?.filter?.year);
  }
}
