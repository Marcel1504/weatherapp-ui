import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/data/current/app_soil_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/data/current/app_weather_current_data_display_fragment.dart';
import 'package:weatherapp_ui/fragments/dialog/data/export/app_soil_export_data_dialog_fragment.dart';
import 'package:weatherapp_ui/fragments/dialog/data/export/app_weather_export_data_dialog_fragment.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/pages/ventilation/app_ventilation_stepper_page.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/providers/summary/single/app_single_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/single/app_soil_single_summary_provider.dart';
import 'package:weatherapp_ui/providers/summary/single/app_weather_single_summary_provider.dart';
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
    Provider.of<AppWeatherSingleSummaryProvider>(context, listen: false)
        .loadLatestByStationCode(context, station?.code);
    return Consumer<AppWeatherSingleSummaryProvider>(
      builder: (context, provider, widget) {
        return _display(
            context,
            provider,
            (p) => AppWeatherCurrentDataDisplayFragment(
                  weather: p.latest,
                ),
            {
              AppIcons.ventilation: () => _openPage(context, const AppVentilationStepperPage()),
              Icons.mail: () => _openExportDialog(context, const AppWeatherExportDataDialogFragment())
            });
      },
    );
  }

  Widget _rootSoil(BuildContext context, AppStationResponseDto? station) {
    Provider.of<AppSoilSingleSummaryProvider>(context, listen: false).loadLatestByStationCode(context, station?.code);
    return Consumer<AppSoilSingleSummaryProvider>(
      builder: (context, provider, widget) {
        return _display(
            context,
            provider,
            (p) => AppSoilCurrentDataDisplayFragment(
                  soil: p.latest,
                ),
            {Icons.mail: () => _openExportDialog(context, const AppSoilExportDataDialogFragment())});
      },
    );
  }

  Widget _display(BuildContext context, AppSingleSummaryProvider provider,
      Widget Function(AppSingleSummaryProvider) widget, Map<IconData, Function()> actions) {
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

  Widget _displayDuration(BuildContext context, AppSingleSummaryProvider provider) {
    String? duration = AppTimeService().transformISOTimeStringToCurrentDuration(context, provider.latest.timestamp);
    AppLayoutService layoutService = AppLayoutService();
    return duration != null
        ? Padding(
            padding: EdgeInsets.only(
                bottom: layoutService.betweenItemPadding(), top: layoutService.betweenItemPadding() * 2),
            child: Text(
              AppLocalizations.of(context)!.weather_current_duration(duration),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: AppLayoutConfig.headlineCurrentDurationFontSize),
            ),
          )
        : Container();
  }

  Widget _displayQuickActions(BuildContext context, Map<IconData, Function()> actions) {
    AppLayoutService layoutService = AppLayoutService();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: actions.entries
          .map((v) => Padding(
                padding: EdgeInsets.only(
                    bottom: layoutService.betweenItemPadding() * 2,
                    right: layoutService.betweenItemPadding(),
                    left: layoutService.betweenItemPadding()),
                child: AppIconButtonComponent(
                  icon: v.key,
                  type: AppButtonTypeEnum.secondary,
                  onTap: () => v.value.call(),
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

  void _openExportDialog(BuildContext context, Widget dialog) {
    showDialog(context: context, builder: (context) => dialog);
  }
}
