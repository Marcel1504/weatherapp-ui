import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/fragments/data/review/filter/app_soil_review_data_filter_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/filter/app_weather_review_data_filter_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/app_soil_review_data_list_fragment.dart';
import 'package:weatherapp_ui/fragments/data/review/list/app_weather_review_data_list_fragment.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppReviewDataFragment extends StatefulWidget {
  const AppReviewDataFragment({super.key});

  @override
  State<AppReviewDataFragment> createState() => _AppReviewDataFragmentState();
}

class _AppReviewDataFragmentState extends State<AppReviewDataFragment> {
  AppCalendarEnum? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStationProvider>(builder: (context, provider, widget) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppLayoutService().maxWidth()),
          child: Column(
            children: [_header(context, provider), _body(provider)],
          ),
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
    _selectedChoice ??= AppCalendarEnum.DAY;
    List<Widget> choiceChips = [
      _choiceChip(AppLocalizations.of(context)!.term_days, AppCalendarEnum.DAY),
      _choiceChip(
          AppLocalizations.of(context)!.term_months, AppCalendarEnum.MONTH),
      _choiceChip(
          AppLocalizations.of(context)!.term_years, AppCalendarEnum.YEAR),
    ];
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: choiceChips
                .map((c) => Padding(
                      padding: EdgeInsets.only(
                          right: AppLayoutService().betweenItemPadding()),
                      child: c,
                    ))
                .toList()),
      ),
    );
  }

  Widget _headerFilterButton(
      BuildContext context, AppStationProvider provider) {
    return Padding(
      padding: EdgeInsets.only(left: AppLayoutService().betweenItemPadding()),
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
          type: _selectedChoice,
        );
        break;
      case AppStationTypeEnum.SOIL:
        body = AppSoilReviewDataListFragment(
          station: provider.selectedStation,
          type: _selectedChoice,
        );
        break;
      default:
        body = Container();
    }
    return Expanded(child: body);
  }

  ChoiceChip _choiceChip(String label, AppCalendarEnum type) {
    bool isSelected = type == _selectedChoice;
    return ChoiceChip(
      label: Text(label,
          style: TextStyle(
            color: Theme.of(context)
                .chipTheme
                .labelStyle!
                .color!
                .withOpacity(isSelected ? 1 : 0.7),
          )),
      selected: isSelected,
      onSelected: (_) => setState(() {
        _selectedChoice = type;
      }),
    );
  }

  void _openFilterDialog(BuildContext context, AppStationProvider provider) {
    Widget? child;
    switch (provider.selectedStation?.type) {
      case AppStationTypeEnum.WEATHER:
        child = AppWeatherReviewDataFilterFragment(
          station: provider.selectedStation,
          type: _selectedChoice,
        );
        break;
      case AppStationTypeEnum.SOIL:
        child = AppSoilReviewDataFilterFragment(
          station: provider.selectedStation,
          type: _selectedChoice,
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
