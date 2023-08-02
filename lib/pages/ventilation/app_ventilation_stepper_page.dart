import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/fragments/form/app_form_field_fragment.dart';
import 'package:weatherapp_ui/fragments/form/app_form_switch_fragment.dart';
import 'package:weatherapp_ui/fragments/stepper/app_stepper_fragment.dart';
import 'package:weatherapp_ui/pages/ventilation/app_ventilation_result_page.dart';
import 'package:weatherapp_ui/providers/data/single/impl/app_weather_single_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/providers/ventilation/app_ventilation_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppVentilationStepperPage extends StatefulWidget {
  const AppVentilationStepperPage({super.key});

  @override
  State<AppVentilationStepperPage> createState() =>
      _AppVentilationStepperPageState();
}

class _AppVentilationStepperPageState extends State<AppVentilationStepperPage> {
  int _currentStep = 0;
  bool _useStationValues = true;
  double? _tempOut;
  bool _tempOutValid = false;
  double? _tempIn;
  bool _tempInValid = false;
  int? _humidityOut;
  bool _humidityOutValid = false;
  int? _humidityIn;
  bool _humidityInValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _stepper(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.ventilation_page),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _stepper(BuildContext context) {
    return AppStepperFragment(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: (context, details) =>
            _controls(context, details.onStepContinue, details.onStepCancel),
        steps: [_firstStep(), _secondStep(), _thirdStep()]);
  }

  _onStepContinue() {
    if (_currentStep == 0 && _useStationValues) {
      setState(() => _currentStep += 2);
    } else if (_currentStep < 2) {
      setState(() => _currentStep += 1);
    } else if (_currentStep == 2) {
      _determineVentilation();
    }
  }

  _onStepCancel() {
    if (_currentStep == 2 && _useStationValues) {
      setState(() => _currentStep -= 2);
    } else if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  _determineVentilation() {
    AppWeatherSingleDataProvider provider =
        Provider.of<AppWeatherSingleDataProvider>(context, listen: false);
    if (_useStationValues) {
      _tempOut = provider.latest?.temperature;
      _humidityOut = provider.latest?.humidity;
    }
    Provider.of<AppVentilationProvider>(context, listen: false)
        .determineNeedForVentilation(
            temperatureOutside: _tempOut,
            temperatureInside: _tempIn,
            humidityOutside: _humidityOut,
            humidityInside: _humidityIn);
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const AppVentilationResultPage(),
          transitionDuration: const Duration(milliseconds: 500),
        ));
  }

  Widget _controls(BuildContext context, VoidCallback? onStepContinue,
      VoidCallback? onStepCancel) {
    return Padding(
      padding: EdgeInsets.only(top: AppLayoutService().betweenItemPadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentStep != 0
              ? AppRoundIconButtonComponent(
                  icon: Icons.close,
                  primary: false,
                  action: onStepCancel,
                )
              : Container(),
          _currentStep != 2
              ? AppRoundIconButtonComponent(
                  icon: Icons.navigate_next,
                  action: _currentStep == 0 ||
                          (_outValuesValid() && _currentStep == 1) ||
                          (_inValuesValid() && _currentStep == 2)
                      ? onStepContinue
                      : null,
                )
              : AppRoundIconButtonComponent(
                  icon: Icons.check,
                  action: _allInputsValid() ? onStepContinue : null,
                ),
        ],
      ),
    );
  }

  Step _firstStep() {
    AppStationProvider provider =
        Provider.of<AppStationProvider>(context, listen: false);

    return Step(
      title: _getStepTitle(
          AppLocalizations.of(context)!.ventilation_use_station_title),
      content: Column(
        children: [
          AppFormSwitchFragment(
            subtitle: AppLocalizations.of(context)!
                .ventilation_use_station_description(
                    provider.selectedStation?.name ?? "?"),
            initial: _useStationValues,
            onChanged: (v) => setState(() => _useStationValues = v),
          )
        ],
      ),
      isActive: _currentStep == 0,
      state: _currentStep == 0
          ? StepState.editing
          : _currentStep > 0
              ? StepState.complete
              : StepState.disabled,
    );
  }

  Step _secondStep() {
    return Step(
      title: _getStepTitle(
          AppLocalizations.of(context)!.ventilation_values_outside),
      content: Column(
        children: [
          AppFormFieldFragment(
              type: TextInputType.number,
              hint: AppLocalizations.of(context)!
                  .ventilation_values_outside_temperature,
              icon: Icons.thermostat,
              filter: FilterType.TEMPERATURE,
              suffix: "°C",
              onChanged: (s, v) {
                setState(() {
                  _tempOut = double.tryParse(s!.replaceAll(",", "."));
                  _tempOutValid = v;
                });
              },
              invalidHint:
                  AppLocalizations.of(context)!.ventilation_invalid_temperature,
              validation: (v) =>
                  v != null && double.tryParse(v.replaceAll(",", ".")) != null),
          AppFormFieldFragment(
              type: TextInputType.number,
              icon: AppIcons.humidity,
              hint: AppLocalizations.of(context)!
                  .ventilation_values_outside_humidity,
              filter: FilterType.HUMIDITY,
              suffix: "%",
              onChanged: (s, v) {
                setState(() {
                  _humidityOut = int.tryParse(s ?? "");
                  _humidityOutValid = v;
                });
              },
              invalidHint:
                  AppLocalizations.of(context)!.ventilation_invalid_humidity,
              validation: (v) => v != null && int.tryParse(v) != null),
        ],
      ),
      isActive: _currentStep == 1,
      state: _currentStep == 1 && !_useStationValues
          ? StepState.editing
          : _currentStep > 1 || _useStationValues
              ? StepState.complete
              : StepState.disabled,
    );
  }

  Step _thirdStep() {
    return Step(
      title: _getStepTitle(
          AppLocalizations.of(context)!.ventilation_values_inside),
      content: Column(
        children: [
          AppFormFieldFragment(
              type: TextInputType.number,
              hint: AppLocalizations.of(context)!
                  .ventilation_values_inside_temperature,
              icon: Icons.thermostat,
              filter: FilterType.TEMPERATURE,
              suffix: "°C",
              onChanged: (s, v) {
                setState(() {
                  _tempIn = double.tryParse(s!.replaceAll(",", "."));
                  _tempInValid = v;
                });
              },
              invalidHint:
                  AppLocalizations.of(context)!.ventilation_invalid_temperature,
              validation: (v) =>
                  v != null && double.tryParse(v.replaceAll(",", ".")) != null),
          AppFormFieldFragment(
              type: TextInputType.number,
              icon: AppIcons.humidity,
              hint: AppLocalizations.of(context)!
                  .ventilation_values_inside_humidity,
              filter: FilterType.HUMIDITY,
              suffix: "%",
              onChanged: (s, v) {
                setState(() {
                  _humidityIn = int.tryParse(s ?? "");
                  _humidityInValid = v;
                });
              },
              invalidHint:
                  AppLocalizations.of(context)!.ventilation_invalid_humidity,
              validation: (v) => v != null && int.tryParse(v) != null),
        ],
      ),
      isActive: _currentStep == 2,
      state: _currentStep == 2
          ? StepState.editing
          : _currentStep > 2
              ? StepState.complete
              : StepState.disabled,
    );
  }

  Text _getStepTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  bool _outValuesValid() {
    return (_tempOutValid && _humidityOutValid) || _useStationValues;
  }

  bool _inValuesValid() {
    return _tempInValid && _humidityInValid;
  }

  bool _allInputsValid() {
    return _outValuesValid() && _inValuesValid();
  }
}
