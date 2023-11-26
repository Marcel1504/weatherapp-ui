import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/dialog/export/app_export_dialog_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/providers/export/app_soil_export_provider.dart';

class AppSoilExportDialogComponent extends StatelessWidget {
  const AppSoilExportDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSoilExportProvider>(builder: (context, provider, widget) {
      return AppExportDialogComponent(title: AppL18nConfig.get(context).export_title_soil, provider: provider);
    });
  }
}
