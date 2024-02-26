import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/scaffold/app_scaffold_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/fragments/station/list/app_station_list_fragment.dart';

class AppStationPage extends StatelessWidget {
  const AppStationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      appBar: _appBar(context),
      body: const AppStationListFragment(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppL18nConfig.get(context).station_selection),
      titleTextStyle:
          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
    );
  }
}
