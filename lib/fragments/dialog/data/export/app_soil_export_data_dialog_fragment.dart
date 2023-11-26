import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/fragments/dialog/data/export/app_export_data_dialog_fragment.dart';
import 'package:weatherapp_ui/providers/export/app_soil_export_provider.dart';

class AppSoilExportDataDialogFragment extends StatelessWidget {
  const AppSoilExportDataDialogFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSoilExportProvider>(builder: (context, provider, widget) {
      return AppExportDataDialogFragment(title: AppLocalizations.of(context)!.export_title_soil, provider: provider);
    });
  }
}
