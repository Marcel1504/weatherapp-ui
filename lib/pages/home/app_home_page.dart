import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/components/button/app_icon_text_button_component.dart';
import 'package:weatherapp_ui/components/scaffold/app_scaffold_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/fragments/station/media/app_station_media_fragment.dart';
import 'package:weatherapp_ui/fragments/summary/current/app_current_summary_fragment.dart';
import 'package:weatherapp_ui/fragments/summary/list/container/app_list_summary_container_fragment.dart';
import 'package:weatherapp_ui/pages/app_root_page.dart';
import 'package:weatherapp_ui/pages/assistant/app_assistant_page.dart';
import 'package:weatherapp_ui/pages/station/app_station_page.dart';
import 'package:weatherapp_ui/providers/app_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
        appBar: _appBar(context), body: _body(context), bottomNavigationBar: _bottomNavigationBar(context));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Consumer<AppStationProvider>(builder: (context, provider, widget) {
        return AppIconTextButtonComponent(
          type: AppButtonTypeEnum.normal,
          icon: AppIcons.station,
          size: 35,
          text: provider.selectedStation?.name ?? AppL18nConfig.get(context).station_unnamed,
          onTap: () => _openStationPage(context),
        );
      }),
      titleTextStyle:
          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
      actions: _appBarActions(context),
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      AppIconButtonComponent(
        icon: Icons.chat,
        size: 55,
        onTap: () => _openAssistantPage(context),
        type: AppButtonTypeEnum.transparent,
      ),
      AppIconButtonComponent(
        icon: Icons.refresh,
        size: 55,
        onTap: () => _refresh(context),
        type: AppButtonTypeEnum.transparent,
      ),
    ];
  }

  Widget _body(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _bodyPages(context)[_selectedIndex],
    );
  }

  List<Widget> _bodyPages(BuildContext context) {
    return [
      const AppListSummaryContainerFragment(),
      const AppCurrentSummaryFragment(),
      const AppStationMediaFragment(),
    ];
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: SalomonBottomBar(
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          selectedColorOpacity: 0.1,
          items: [
            SalomonBottomBarItem(icon: const Icon(AppIcons.past), title: Text(AppL18nConfig.get(context).page_review)),
            SalomonBottomBarItem(
                icon: const Icon(Icons.trending_up), title: Text(AppL18nConfig.get(context).page_current)),
            SalomonBottomBarItem(icon: const Icon(Icons.image), title: Text(AppL18nConfig.get(context).page_media))
          ],
          currentIndex: _selectedIndex,
          onTap: _onBottomNavigationTapped),
    );
  }

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openAssistantPage(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppAssistantPage(),
        ));
  }

  void _openStationPage(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppStationPage(),
        ));
  }

  void _refresh(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppRootPage(),
        )).then((_) => AppProvider().reset(context));
  }
}
