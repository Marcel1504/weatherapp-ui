import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppStationListItemFragment extends StatelessWidget {
  final AppStationResponseDto? station;
  final bool isSelected;

  const AppStationListItemFragment({super.key, this.station, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
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
            children: [_stationNameText(context, station), _stationLastActivityText(context, station)],
          ),
          isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : Container()
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

  Widget _stationNameText(BuildContext context, AppStationResponseDto? station) {
    return Text(station?.name ?? "",
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize));
  }

  Widget _stationLastActivityText(BuildContext context, AppStationResponseDto? station) {
    String? duration = AppTimeService().transformISOTimeStringToCurrentDuration(context, station?.lastActivity);
    return Padding(
      padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing * 0.5),
      child: Text(
          duration != null
              ? AppL18nConfig.get(context).station_last_activity(duration)
              : AppL18nConfig.get(context).station_last_activity_unknown,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: AppLayoutConfig.defaultTextLabelFontSize)),
    );
  }

  void _selectStation(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppStationProvider>(context, listen: false).changeSelectedStation(station?.code);
    Navigator.of(context).pop();
  }
}
