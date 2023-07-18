import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:weatherapp_ui/fragments/data/current/app_current_data_fragment.dart';
import 'package:weatherapp_ui/fragments/station/list/app_station_list_fragment.dart';
import 'package:weatherapp_ui/pages/app_root_page.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
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
    return Scaffold(
        appBar: _appBar(context),
        body: _body(context),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Consumer<AppStationProvider>(builder: (context, provider, widget) {
        return Text(provider.selectedStation?.name ??
            AppLocalizations.of(context)!.station_unnamed);
      }),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      actions: _appBarActions(context),
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

  Widget _body(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _bodyPages(context)[_selectedIndex],
    );
  }

  List<Widget> _bodyPages(BuildContext context) {
    return [
      Container(),
      const AppCurrentDataFragment(),
      const AppStationListFragment()
    ];
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

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refresh(BuildContext context) {
    Provider.of<AppWeatherSingleDataProvider>(context, listen: false)
        .markForReset();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppRootPage(),
        ));
  }
}
