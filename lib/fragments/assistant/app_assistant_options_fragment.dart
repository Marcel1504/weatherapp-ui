import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/button/app_icon_text_button_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppAssistantOptionsFragment extends StatelessWidget {
  final Function(String)? optionSelected;

  const AppAssistantOptionsFragment({super.key, this.optionSelected});

  @override
  Widget build(BuildContext context) {
    String station = Provider.of<AppStationProvider>(context, listen: false).selectedStation?.name ?? "?";
    List<Widget> widgets = [
      _icon(context),
      _headline(context),
      _intro(context),
      _option(context, AppL18nConfig.get(context).chat_assistant_intro_question1),
      _option(context, AppL18nConfig.get(context).chat_assistant_intro_question2),
      _option(context, AppL18nConfig.get(context).chat_assistant_intro_question3(station))
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: widgets
              .map((w) => Padding(
            padding: const EdgeInsets.only(bottom: AppLayoutConfig.defaultSpacing),
                    child: w,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _icon(BuildContext context) {
    return Icon(
      AppIcons.weather,
      color: Theme.of(context).colorScheme.secondary,
      size: AppLayoutConfig.iconAssistantIntroSize,
    );
  }

  Widget _headline(BuildContext context) {
    return Text(
      AppL18nConfig.get(context).chat_assistant_intro_headline,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: AppLayoutConfig.textAssistantIntroHeadlineFontSize, color: Theme.of(context).colorScheme.secondary),
    );
  }

  Widget _intro(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppLayoutConfig.textAssistantIntroTextMaxWidth),
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppLayoutConfig.defaultSpacing * 2),
        child: Text(
          AppL18nConfig.get(context).chat_assistant_intro_text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: AppLayoutConfig.textAssistantIntroTextFontSize),
        ),
      ),
    );
  }

  Widget _option(BuildContext context, String option) {
    return AppIconTextButtonComponent(
      text: option,
      type: AppButtonTypeEnum.secondary,
      scrollText: true,
      onTap: () => optionSelected?.call(option),
    );
  }
}
