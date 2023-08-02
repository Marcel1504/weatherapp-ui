import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/fragments/data/current/app_soil_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/data/current/app_weather_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/pages/ventilation/app_ventilation_stepper_page.dart';
import 'package:weatherapp_ui/providers/data/single/app_single_data_provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_soil_single_data_provider.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppCurrentDataFragment extends StatelessWidget {
  const AppCurrentDataFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStationProvider>(
      builder: (context, provider, widget) {
        AppStationResponseDto? station = provider.selectedStation;
        switch (station?.type) {
          case AppStationTypeEnum.WEATHER:
            return _rootWeather(context, station);
          case AppStationTypeEnum.SOIL:
            return _rootSoil(context, station);
          default:
            return Container();
        }
      },
    );
  }

  Widget _rootWeather(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppWeatherSingleDataProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);
    return Consumer<AppWeatherSingleDataProvider>(
      builder: (context, provider, widget) {
        return _display(
            context,
            provider,
            (p) => AppWeatherCurrentDataDisplayFragment(
                  weather: p.latest,
                ),
            {
              AppIcons.ventilation: () =>
                  _openPage(context, const AppVentilationStepperPage())
            });
      },
    );
  }

  Widget _rootSoil(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppSoilSingleDataProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);
    return Consumer<AppSoilSingleDataProvider>(
      builder: (context, provider, widget) {
        return _display(
            context,
            provider,
            (p) => AppSoilCurrentDataDisplayFragment(
                  soil: p.latest,
                ),
            {});
      },
    );
  }

  Widget _display(
      BuildContext context,
      AppSingleDataProvider provider,
      Widget Function(AppSingleDataProvider) widget,
      Map<IconData, Function()> actions) {
    return provider.loading
        ? const Center(
            child: AppLoadingFragment(
              size: 50,
            ),
          )
        : Column(
            children: [
              _displayDuration(context, provider),
              Expanded(
                child: Center(child: widget.call(provider)),
              ),
              _displayQuickActions(context, actions)
            ],
          );
  }

  Widget _displayDuration(
      BuildContext context, AppSingleDataProvider provider) {
    String? duration = AppTimeService().transformISOTimeStringToCurrentDuration(
        context, provider.latest.timestamp);
    AppLayoutService layoutService = AppLayoutService();
    return duration != null
        ? Padding(
            padding: EdgeInsets.only(
                bottom: layoutService.betweenItemPadding(),
                top: layoutService.betweenItemPadding() * 2),
            child: Text(
              AppLocalizations.of(context)!.weather_current_duration(duration),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : Container();
  }

  Widget _displayQuickActions(
      BuildContext context, Map<IconData, Function()> actions) {
    AppLayoutService layoutService = AppLayoutService();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: actions.entries
          .map((v) => Padding(
                padding: EdgeInsets.only(
                    bottom: layoutService.betweenItemPadding() * 2,
                    right: layoutService.betweenItemPadding(),
                    left: layoutService.betweenItemPadding()),
                child: AppRoundIconButtonComponent(
                  icon: v.key,
                  primary: false,
                  action: () => v.value.call(),
                ),
              ))
          .toList(),
    );
  }

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => page,
        ));
  }
}
