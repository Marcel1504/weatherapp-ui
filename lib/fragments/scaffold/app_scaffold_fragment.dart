import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

class AppScaffoldFragment extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const AppScaffoldFragment({super.key, this.body, this.appBar, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundImage(context),
        _backgroundDecoration(context),
        Scaffold(appBar: appBar, body: body, bottomNavigationBar: bottomNavigationBar)
      ],
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Consumer<AppStationProvider>(builder: (context, provider, child) {
      Uint8List? base64 = provider.selectedStationMediaFileLatest?.data;
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            image: base64 != null ? DecorationImage(fit: BoxFit.cover, image: MemoryImage(base64)) : null),
      );
    });
  }

  Widget _backgroundDecoration(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background.withOpacity(0.95),
    );
  }
}
