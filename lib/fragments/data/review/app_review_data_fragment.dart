import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/fragments/chip/app_choice_chip_list_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/app_soil_review_data_list_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/app_weather_review_data_list_fragment.dart';
import 'package:weatherapp_ui/fragments/dialog/data/filter/app_soil_data_filter_dialog_fragment.dart';
import 'package:weatherapp_ui/fragments/dialog/data/filter/app_weather_data_filter_dialog_fragment.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppReviewDataFragment extends StatefulWidget {
  const AppReviewDataFragment({super.key});

  @override
  State<AppReviewDataFragment> createState() => _AppReviewDataFragmentState();
}

class _AppReviewDataFragmentState extends State<AppReviewDataFragment> {
  int _selectedTimeIndex = 0;
  List<String> _timeTitles = [];
  List<AppCalendarEnum> _timeTypes = [];

  @override
  Widget build(BuildContext context) {
    _timeTitles = [
      AppLocalizations.of(context)!.term_days,
      AppLocalizations.of(context)!.term_months,
      AppLocalizations.of(context)!.term_years,
    ];
    _timeTypes = [
      AppCalendarEnum.DAY,
      AppCalendarEnum.MONTH,
      AppCalendarEnum.YEAR
    ];
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
      padding: EdgeInsets.all(AppLayoutService().betweenItemPadding()),
      child: Row(
        children: [
          _headerChoices(context, provider),
          _headerFilterButton(context, provider)
        ],
      ),
    );
  }

  Widget _headerChoices(BuildContext context, AppStationProvider provider) {
    return Expanded(
        child: AppChoiceChipListFragment(
      titles: _timeTitles,
      onTap: (i) => setState(() => _selectedTimeIndex = i),
    ));
  }

  Widget _headerFilterButton(
      BuildContext context, AppStationProvider provider) {
    AppLayoutService layoutService = AppLayoutService();
    return Padding(
      padding: EdgeInsets.only(
          left: layoutService.betweenItemPadding(),
          bottom: layoutService.betweenItemPadding() * 1.2),
      child: AppRoundIconButtonComponent(
        icon: Icons.filter_alt,
        size: 18,
        primary: false,
        action: () => _openFilterDialog(context, provider),
      ),
    );
  }

  Widget _body(AppStationProvider provider) {
    Widget? body;
    switch (provider.selectedStation?.type) {
      case AppStationTypeEnum.WEATHER:
        body = AppWeatherReviewDataListFragment(
          station: provider.selectedStation,
          type: _timeTypes[_selectedTimeIndex],
        );
        break;
      case AppStationTypeEnum.SOIL:
        body = AppSoilReviewDataListFragment(
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
        child = AppWeatherDataFilterDialogFragment(
          station: provider.selectedStation,
          type: _timeTypes[_selectedTimeIndex],
        );
        break;
      case AppStationTypeEnum.SOIL:
        child = AppSoilDataFilterDialogFragment(
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
