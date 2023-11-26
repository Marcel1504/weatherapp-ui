import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/dialog/export/app_export_dialog_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/providers/export/app_weather_export_provider.dart';

class AppWeatherExportDialogComponent extends StatelessWidget {
  const AppWeatherExportDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppWeatherExportProvider>(builder: (context, provider, widget) {
      return AppExportDialogComponent(title: AppL18nConfig.get(context).export_title_weather, provider: provider);
    });
  }
}
