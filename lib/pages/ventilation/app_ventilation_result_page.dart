import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/enums/app_ventilation_indicator_enum.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/fragments/scaffold/app_scaffold_fragment.dart';
import 'package:weatherapp_ui/fragments/text/app_data_text_fragment.dart';
import 'package:weatherapp_ui/providers/ventilation/app_ventilation_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppVentilationResultPage extends StatelessWidget {
  const AppVentilationResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldFragment(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.ventilation_page),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Consumer<AppVentilationProvider>(
          builder: (context, provider, widget) {
        return provider.loading
            ? const AppLoadingFragment(
                size: 30,
              )
            : _resultRoot(context, provider);
      }),
    );
  }

  Widget _resultRoot(BuildContext context, AppVentilationProvider provider) {
    return Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _indicatorArea(context, provider),
          _dataArea(context, provider)
        ]);
  }

  Widget _indicatorArea(BuildContext context, AppVentilationProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Center(child: _getIcon(context, provider)),
          Text(
            _getText(context, provider),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: AppLayoutService().betweenItemPadding()),
            child: Text(_getDescription(context, provider),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _dataArea(BuildContext context, AppVentilationProvider provider) {
    return provider.result != null
        ? GridView.count(
            shrinkWrap: true,
            childAspectRatio: (MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height) *
                5,
            crossAxisCount: 2,
            children: [
              _dataHeadline(context,
                  AppLocalizations.of(context)!.ventilation_values_outside),
              _dataHeadline(context,
                  AppLocalizations.of(context)!.ventilation_values_inside),
              AppDataTextFragment(
                  value: provider.temperatureOutside.toString(),
                  iconData: Icons.thermostat,
                  title: AppLocalizations.of(context)!
                      .ventilation_values_outside_temperature,
                  valueSuffix: "°C"),
              AppDataTextFragment(
                  value: provider.temperatureInside.toString(),
                  iconData: Icons.thermostat,
                  title: AppLocalizations.of(context)!
                      .ventilation_values_inside_temperature,
                  valueSuffix: "°C"),
              AppDataTextFragment(
                  value: provider.humidityOutside.toString(),
                  iconData: AppIcons.humidity,
                  title: AppLocalizations.of(context)!
                      .ventilation_values_outside_humidity,
                  valueSuffix: "%"),
              AppDataTextFragment(
                  value: provider.humidityInside.toString(),
                  iconData: AppIcons.humidity,
                  title: AppLocalizations.of(context)!
                      .ventilation_values_inside_humidity,
                  valueSuffix: "%"),
              AppDataTextFragment(
                  value: provider.result?.absoluteHumidityOut.toString(),
                  iconData: AppIcons.humidity,
                  title: AppLocalizations.of(context)!
                      .ventilation_values_outside_humidity_absolute,
                  valueSuffix: "g/m³"),
              AppDataTextFragment(
                  value: provider.result?.absoluteHumidityIn.toString(),
                  iconData: AppIcons.humidity,
                  title: AppLocalizations.of(context)!
                      .ventilation_values_inside_humidity_absolute,
                  valueSuffix: "g/m³"),
            ],
          )
        : Container();
  }

  Icon? _getIcon(BuildContext context, AppVentilationProvider provider) {
    switch (provider.result?.indicator) {
      case AppVentilationIndicatorEnum.RED:
        return Icon(
          Icons.warning,
          color: _getRed(context),
          size: 120,
        );
      case AppVentilationIndicatorEnum.YELLOW1:
      case AppVentilationIndicatorEnum.YELLOW2:
        return Icon(
          Icons.warning,
          color: _getYellow(context),
          size: 120,
        );
      case AppVentilationIndicatorEnum.GREEN:
        return Icon(
          Icons.check_circle,
          color: _getGreen(context),
          size: 120,
        );
      default:
        return null;
    }
  }

  String _getText(BuildContext context, AppVentilationProvider provider) {
    switch (provider.result?.indicator) {
      case AppVentilationIndicatorEnum.RED:
        return AppLocalizations.of(context)!.ventilation_result_red_title;
      case AppVentilationIndicatorEnum.YELLOW1:
      case AppVentilationIndicatorEnum.YELLOW2:
        return AppLocalizations.of(context)!.ventilation_result_yellow_title;
      case AppVentilationIndicatorEnum.GREEN:
        return AppLocalizations.of(context)!.ventilation_result_green_title;
      default:
        return AppLocalizations.of(context)!.ventilation_result_no_data;
    }
  }

  String _getDescription(
      BuildContext context, AppVentilationProvider provider) {
    switch (provider.result?.indicator) {
      case AppVentilationIndicatorEnum.RED:
        return AppLocalizations.of(context)!.ventilation_result_red_description;
      case AppVentilationIndicatorEnum.YELLOW1:
        return AppLocalizations.of(context)!
            .ventilation_result_yellow1_description;
      case AppVentilationIndicatorEnum.YELLOW2:
        return AppLocalizations.of(context)!
            .ventilation_result_yellow2_description;
      case AppVentilationIndicatorEnum.GREEN:
        return AppLocalizations.of(context)!
            .ventilation_result_green_description;
      default:
        return "";
    }
  }

  Widget _dataHeadline(BuildContext context, String data) {
    return Center(
      child: Text(
        data,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Color _getGreen(BuildContext context) {
    return Color.alphaBlend(const Color.fromRGBO(0, 255, 0, 0.7),
        Theme.of(context).colorScheme.onBackground);
  }

  Color _getRed(BuildContext context) {
    return Color.alphaBlend(const Color.fromRGBO(255, 0, 0, 0.7),
        Theme.of(context).colorScheme.onBackground);
  }

  Color _getYellow(BuildContext context) {
    return Color.alphaBlend(const Color.fromRGBO(255, 255, 0, 0.7),
        Theme.of(context).colorScheme.onBackground);
  }
}
