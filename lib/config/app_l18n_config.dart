import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppL18nConfig {
  static AppLocalizations get(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
