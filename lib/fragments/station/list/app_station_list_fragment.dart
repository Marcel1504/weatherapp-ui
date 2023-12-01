import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/fragments/station/list/app_station_list_item_fragment.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

class AppStationListFragment extends StatelessWidget {
  const AppStationListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStationProvider>(builder: (context, provider, widget) {
      return Center(
        child: _list(context, provider),
      );
    });
  }

  Widget _list(BuildContext context, AppStationProvider provider) {
    return ListView.separated(
        itemBuilder: (context, index) => AppStationListItemFragment(
              station: provider.stations[index],
              isSelected: provider.stations[index].code == provider.selectedStation?.code,
            ),
        separatorBuilder: (a, b) => const Divider(),
        itemCount: provider.stations.length);
  }
}
