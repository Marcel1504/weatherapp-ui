import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppStationListItemFragment extends StatelessWidget {
  final AppStationResponseDto? station;
  final bool isSelected;

  const AppStationListItemFragment(
      {super.key, this.station, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();

    return ListTile(
      leading: Icon(
        _leadingIcon(station?.type),
        size: 30,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
      ),
      tileColor: Colors.transparent,
      onTap: () => _selectStation(context, station),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stationNameText(context, station, layoutService),
              _stationLastActivityText(context, station, layoutService)
            ],
          ),
          isSelected
              ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              : Container()
        ],
      ),
    );
  }

  IconData _leadingIcon(AppStationTypeEnum? type) {
    switch (type) {
      case AppStationTypeEnum.WEATHER:
        return AppIcons.weather;
      case AppStationTypeEnum.SOIL:
        return AppIcons.soil;
      default:
        return Icons.question_mark;
    }
  }

  Widget _stationNameText(BuildContext context, AppStationResponseDto? station,
      AppLayoutService layoutService) {
    return Text(station?.name ?? "",
        style: Theme.of(context).textTheme.headlineMedium);
  }

  Widget _stationLastActivityText(BuildContext context,
      AppStationResponseDto? station, AppLayoutService layoutService) {
    String? duration = AppTimeService().transformISOTimeStringToCurrentDuration(
        context, station?.lastActivity);
    return Padding(
      padding: EdgeInsets.only(top: layoutService.betweenItemPadding() / 2),
      child: Text(
          duration != null
              ? AppLocalizations.of(context)!.station_last_activity(duration)
              : AppLocalizations.of(context)!.station_last_activity_unknown,
          style: Theme.of(context).textTheme.bodySmall),
    );
  }

  void _selectStation(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppStationProvider>(context, listen: false)
        .changeSelectedStation(station?.code);
  }
}
