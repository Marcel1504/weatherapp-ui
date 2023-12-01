import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/pages/app_root_page.dart';
import 'package:weatherapp_ui/pages/info/app_info_page.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';

class AppVersionInfoPage extends StatelessWidget {
  const AppVersionInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigurationService configurationService = AppConfigurationService();
    return AppInfoPage(
      nextPage: () => const AppRootPage(),
      onAccept: () => configurationService.saveVersionInfoShown(),
      shouldShow: configurationService.getVersionInfoShown(),
      child: Column(
        children: [
          _header(context),
          _section(context, AppL18nConfig.get(context).page_info_version_section1_headline,
              AppL18nConfig.get(context).page_info_version_section1_body),
          _section(context, AppL18nConfig.get(context).page_info_version_section2_headline,
              AppL18nConfig.get(context).page_info_version_section2_body),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text(
      AppL18nConfig.get(context).page_info_version_title,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: Theme.of(context).colorScheme.secondary, fontSize: AppLayoutConfig.textInfoHeadlineFontSize),
    );
  }

  Widget _section(BuildContext context, String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing * 3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppLayoutConfig.defaultSpacing),
            child: Text(
              title,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.justify,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
          )
        ],
      ),
    );
  }
}
