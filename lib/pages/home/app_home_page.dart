import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/fragments/button/app_rounded_icon_button.dart';
import 'package:weatherapp_ui/pages/app_root_page.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;
  late List<Widget> _bodyWidgets;

  @override
  void initState() {
    super.initState();
    _bodyWidgets = [
      _test(),
      Text("Test 2", key: ValueKey(2)),
      Text("Test 3", key: ValueKey(3))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: _body(context),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  Widget _test() {
    return Row(
      children: [
        AppRoundIconButtonComponent(
          primary: false,
          icon: Icons.refresh,
        ),
        AppRoundIconButtonComponent(
          primary: true,
          icon: Icons.refresh,
        ),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Consumer<AppStationProvider>(builder: (c, provider, widget) {
        return Text(provider.selectedStation?.name ??
            AppLocalizations.of(context)!.station_unnamed);
      }),
      titleTextStyle: AppLayoutService().appTextStyle(context,
          size: "l", color: "background", withOpacity: true),
      actions: _appBarActions(context),
    );
  }

  Widget _body(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _bodyWidgets[_selectedIndex],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: SalomonBottomBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          selectedColorOpacity: 0.1,
          items: [
            SalomonBottomBarItem(
                icon: const Icon(AppIcons.past),
                title: Text(AppLocalizations.of(context)!.page_review)),
            SalomonBottomBarItem(
                icon: const Icon(Icons.trending_up),
                title: Text(AppLocalizations.of(context)!.page_current)),
            SalomonBottomBarItem(
                icon: const Icon(AppIcons.station),
                title: Text(AppLocalizations.of(context)!.page_stations))
          ],
          currentIndex: _selectedIndex,
          onTap: _onBottomNavigationTapped),
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      SizedBox(
        width: 55,
        height: 55,
        child: InkWell(
          onTap: () => _refresh(context),
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
          child: const Icon(Icons.refresh),
        ),
      )
    ];
  }

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refresh(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppRootPage(),
        ));
  }
}
