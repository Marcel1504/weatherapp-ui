import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/pages/app_root_page.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppWelcomePage extends StatelessWidget {
  const AppWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigurationService service = AppConfigurationService();
    service.getWelcomeInfoShown().then((shown) {
      if (shown ?? false) {
        _openRootPage(context);
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 300),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                AppLocalizations.of(context)!.dialog_welcome_title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              service.isAndroid()
                  ? _forAndroid(context)
                  : service.isIOS()
                      ? _forIOS(context)
                      : _forNonMobile(context),
              Padding(
                padding:
                    EdgeInsets.all(AppLayoutService().betweenItemPadding()),
                child: AppRoundIconButtonComponent(
                  icon: Icons.check,
                  action: () {
                    service.saveWelcomeInfoShown();
                    _openRootPage(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _forAndroid(BuildContext context) {
    return Column(
      children: [
        _tile(context,
            AppLocalizations.of(context)!.dialog_welcome_install_android, null),
        _tile(
            context,
            AppLocalizations.of(context)!.dialog_welcome_android_three_dots,
            Icons.more_vert),
        _tile(
            context,
            AppLocalizations.of(context)!.dialog_welcome_android_install,
            Icons.add_to_home_screen),
      ],
    );
  }

  Widget _forIOS(BuildContext context) {
    return Column(
      children: [
        _tile(context, AppLocalizations.of(context)!.dialog_welcome_install_ios,
            null),
        _tile(
            context,
            AppLocalizations.of(context)!.dialog_welcome_ios_safari_menu,
            Icons.open_in_new),
        _tile(
            context,
            AppLocalizations.of(context)!.dialog_welcome_ios_home_screen,
            Icons.add_box)
      ],
    );
  }

  Widget _forNonMobile(BuildContext context) {
    return Column(
      children: [
        _tile(context,
            AppLocalizations.of(context)!.dialog_welcome_install_desktop, null)
      ],
    );
  }

  ListTile _tile(BuildContext context, String title, IconData? icon) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, color: Theme.of(context).colorScheme.onSurface)
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  void _openRootPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppRootPage(),
        ));
  }
}