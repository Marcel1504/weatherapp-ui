import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/pages/info/app_info_page.dart';
import 'package:weatherapp_ui/pages/info/app_version_info_page.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';

class AppWelcomeInfoPage extends StatelessWidget {
  const AppWelcomeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigurationService configurationService = AppConfigurationService();
    return AppInfoPage(
        nextPage: () => const AppVersionInfoPage(),
        onAccept: () => configurationService.saveWelcomeInfoShown(),
        shouldShow: configurationService.getWelcomeInfoShown(),
        child: Column(
          children: [
            _header(context),
            configurationService.isAndroid()
                ? _forAndroid(context)
                : configurationService.isIOS()
                    ? _forIOS(context)
                    : _forNonMobile(context),
          ],
        ));
  }

  Widget _header(BuildContext context) {
    return Text(
      AppL18nConfig.get(context).page_info_welcome_title,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: Theme.of(context).colorScheme.secondary, fontSize: AppLayoutConfig.textInfoHeadlineFontSize),
    );
  }

  Widget _forAndroid(BuildContext context) {
    return Column(
      children: [
        _tile(context, AppL18nConfig.get(context).page_info_welcome_install_android, null),
        _tile(context, AppL18nConfig.get(context).page_info_welcome_android_three_dots, Icons.more_vert),
        _tile(context, AppL18nConfig.get(context).page_info_welcome_android_install, Icons.add_to_home_screen),
      ],
    );
  }

  Widget _forIOS(BuildContext context) {
    return Column(
      children: [
        _tile(context, AppL18nConfig.get(context).page_info_welcome_install_ios, null),
        _tile(context, AppL18nConfig.get(context).page_info_welcome_ios_safari_menu, Icons.open_in_new),
        _tile(context, AppL18nConfig.get(context).page_info_welcome_ios_home_screen, Icons.add_box)
      ],
    );
  }

  Widget _forNonMobile(BuildContext context) {
    return Column(
      children: [
        _tile(
          context,
          AppL18nConfig.get(context).page_info_welcome_install_desktop,
          Icons.desktop_access_disabled,
        )
      ],
    );
  }

  Widget _tile(BuildContext context, String title, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing * 3),
      child: Row(
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: AppLayoutConfig.defaultSpacing * 2),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: AppLayoutConfig.defaultTextHeadlineFontSize * 1.5,
                  ),
                )
              : Container(),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
            ),
          )
        ],
      ),
    );
  }
}
