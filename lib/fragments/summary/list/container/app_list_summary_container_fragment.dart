import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/components/chip/app_choice_chip_list_component.dart';
import 'package:weatherapp_ui/components/dialog/filter/app_soil_filter_dialog_component.dart';
import 'package:weatherapp_ui/components/dialog/filter/app_weather_filter_dialog_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/summary/list/app_soil_list_summary_fragment.dart';
import 'package:weatherapp_ui/fragments/summary/list/app_weather_list_summary_fragment.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

class AppListSummaryContainerFragment extends StatefulWidget {
  const AppListSummaryContainerFragment({super.key});

  @override
  State<AppListSummaryContainerFragment> createState() => _AppListSummaryContainerFragmentState();
}

class _AppListSummaryContainerFragmentState extends State<AppListSummaryContainerFragment> {
  int _selectedTimeIndex = 0;
  List<String> _timeTitles = [];
  List<AppCalendarEnum> _timeTypes = [];

  @override
  Widget build(BuildContext context) {
    _timeTitles = [
      AppL18nConfig.get(context).term_days,
      AppL18nConfig.get(context).term_months,
      AppL18nConfig.get(context).term_years,
    ];
    _timeTypes = [AppCalendarEnum.DAY, AppCalendarEnum.MONTH, AppCalendarEnum.YEAR];
    return Consumer<AppStationProvider>(builder: (context, provider, widget) {
      return Center(
        child: Column(
          children: [_header(context, provider), _body(provider)],
        ),
      );
    });
  }

  Widget _header(BuildContext context, AppStationProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing),
      child: Row(
        children: [_headerChoices(context, provider), _headerFilterButton(context, provider)],
      ),
    );
  }

  Widget _headerChoices(BuildContext context, AppStationProvider provider) {
    return Expanded(
        child: AppChoiceChipListComponent(
      titles: _timeTitles,
      onTap: (i) => setState(() => _selectedTimeIndex = i),
    ));
  }

  Widget _headerFilterButton(BuildContext context, AppStationProvider provider) {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppLayoutConfig.defaultSpacing, bottom: AppLayoutConfig.defaultSpacing * 1.2),
      child: AppIconButtonComponent(
        icon: Icons.filter_alt,
        size: AppLayoutConfig.buttonReviewFilterSize,
        type: AppButtonTypeEnum.secondary,
        onTap: () => _openFilterDialog(context, provider),
      ),
    );
  }

  Widget _body(AppStationProvider provider) {
    Widget? body;
    switch (provider.selectedStation?.type) {
      case AppStationTypeEnum.WEATHER:
        body = AppWeatherListSummaryFragment(
          station: provider.selectedStation,
          type: _timeTypes[_selectedTimeIndex],
        );
        break;
      case AppStationTypeEnum.SOIL:
        body = AppSoilListSummaryFragment(
          station: provider.selectedStation,
          type: _timeTypes[_selectedTimeIndex],
        );
        break;
      default:
        body = Container();
    }
    return Expanded(child: body);
  }

  void _openFilterDialog(BuildContext context, AppStationProvider provider) {
    Widget? child;
    switch (provider.selectedStation?.type) {
      case AppStationTypeEnum.WEATHER:
        child = AppWeatherFilterDialogComponent(
          station: provider.selectedStation,
          type: _timeTypes[_selectedTimeIndex],
        );
        break;
      case AppStationTypeEnum.SOIL:
        child = AppSoilFilterDialogComponent(
          station: provider.selectedStation,
          type: _timeTypes[_selectedTimeIndex],
        );
        break;
      default:
        break;
    }
    if (child != null) {
      showDialog(
          context: context,
          builder: (context) {
            return child!;
          });
    }
  }
}
