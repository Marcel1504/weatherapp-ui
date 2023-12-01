import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/dialog/app_dialog_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';

class AppAssistantDisclaimerDialog extends StatelessWidget {
  const AppAssistantDisclaimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialogComponent(
      title: AppL18nConfig.get(context).chat_assistant_disclaimer_title,
      titlePrimary: true,
      onAccept: () => AppConfigurationService().saveAssistantDisclaimerShown(),
      height: AppLayoutConfig.dialogAssistantDisclaimerHeight,
      width: AppLayoutConfig.dialogAssistantDisclaimerWidth,
      child: SingleChildScrollView(
        child: Text(
          AppL18nConfig.get(context).chat_assistant_disclaimer_text,
          textAlign: TextAlign.justify,
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
        ),
      ),
    );
  }
}
