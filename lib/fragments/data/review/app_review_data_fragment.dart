import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/fragments/data/review/app_review_data_list_fragment.dart';
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
    AppLayoutService layoutService = AppLayoutService();

    return Consumer<AppStationProvider>(builder: (context, provider, widget) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(layoutService.betweenItemPadding()),
            child: Row(
                children: _getChoiceChips(provider.selectedStation)
                    .map((c) => Padding(
                          padding: EdgeInsets.only(
                              right: layoutService.betweenItemPadding()),
                          child: c,
                        ))
                    .toList()),
          ),
          Expanded(
              child: AppReviewDataListFragment(
            station: provider.selectedStation,
            type: _selectedChoice,
          ))
        ],
      );
    });
  }

  List<Widget> _getChoiceChips(AppStationResponseDto? station) {
    _selectedChoice ??= AppCalendarEnum.DAY;
    return [
      _choiceChip("Tage", AppCalendarEnum.DAY),
      _choiceChip("Monate", AppCalendarEnum.MONTH),
      _choiceChip("Jahre", AppCalendarEnum.YEAR),
    ];
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
}
