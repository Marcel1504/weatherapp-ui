import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/components/input/app_value_input_component.dart';
import 'package:weatherapp_ui/components/scaffold/app_scaffold_component.dart';
import 'package:weatherapp_ui/components/stepper/app_stepper_component.dart';
import 'package:weatherapp_ui/components/switch/app_switch_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/pages/ventilation/app_ventilation_result_page.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/providers/summary/single/app_weather_single_summary_provider.dart';
import 'package:weatherapp_ui/providers/ventilation/app_ventilation_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppVentilationStepperPage extends StatefulWidget {
  const AppVentilationStepperPage({super.key});

  @override
  State<AppVentilationStepperPage> createState() => _AppVentilationStepperPageState();
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
    return AppScaffoldComponent(
      appBar: _appBar(context),
      body: _stepper(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppL18nConfig.get(context).ventilation_page),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _stepper(BuildContext context) {
    return AppStepperComponent(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: (context, details) => _controls(context, details.onStepContinue, details.onStepCancel),
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
    AppWeatherSingleSummaryProvider provider = Provider.of<AppWeatherSingleSummaryProvider>(context, listen: false);
    if (_useStationValues) {
      _tempOut = provider.latest?.temperature;
      _humidityOut = provider.latest?.humidity;
    }
    Provider.of<AppVentilationProvider>(context, listen: false).determineNeedForVentilation(
        temperatureOutside: _tempOut,
        temperatureInside: _tempIn,
        humidityOutside: _humidityOut,
        humidityInside: _humidityIn);
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppVentilationResultPage(),
          transitionDuration: const Duration(milliseconds: 500),
        ));
  }

  Widget _controls(BuildContext context, VoidCallback? onStepContinue, VoidCallback? onStepCancel) {
    return Padding(
      padding: EdgeInsets.only(top: AppLayoutService().betweenItemPadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentStep != 0
              ? AppIconButtonComponent(
                  icon: Icons.close,
                  type: AppButtonTypeEnum.secondary,
                  onTap: onStepCancel,
                )
              : Container(),
          _currentStep != 2
              ? AppIconButtonComponent(
                  icon: Icons.navigate_next,
                  type: AppButtonTypeEnum.primary,
                  onTap: _currentStep == 0 ||
                          (_outValuesValid() && _currentStep == 1) ||
                          (_inValuesValid() && _currentStep == 2)
                      ? onStepContinue
                      : null,
                )
              : AppIconButtonComponent(
                  icon: Icons.check,
                  type: AppButtonTypeEnum.primary,
                  onTap: _allInputsValid() ? onStepContinue : null,
                ),
        ],
      ),
    );
  }

  Step _firstStep() {
    AppStationProvider provider = Provider.of<AppStationProvider>(context, listen: false);
    return Step(
      title: _getStepTitle(AppL18nConfig.get(context).ventilation_use_station_title),
      content: Column(
        children: [
          AppSwitchComponent(
            subtitle:
                AppL18nConfig.get(context).ventilation_use_station_description(provider.selectedStation?.name ?? "?"),
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
      title: _getStepTitle(AppL18nConfig.get(context).ventilation_values_outside),
      content: Column(
        children: [_secondStepTemperatureInput(), _secondStepHumidityInput()],
      ),
      isActive: _currentStep == 1,
      state: _currentStep == 1 && !_useStationValues
          ? StepState.editing
          : _currentStep > 1 || _useStationValues
              ? StepState.complete
              : StepState.disabled,
    );
  }

  Widget _secondStepTemperatureInput() {
    return AppValueInputComponent(
        type: ValueType.temperature,
        hint: AppL18nConfig.get(context).ventilation_values_outside_temperature,
        icon: Icons.thermostat,
        onChanged: (s, v) {
          setState(() {
            _tempOut = double.tryParse(s!.replaceAll(",", "."));
            _tempOutValid = v;
          });
        },
        invalidHint: AppL18nConfig.get(context).ventilation_invalid_temperature);
  }

  Widget _secondStepHumidityInput() {
    return Padding(
        padding: const EdgeInsets.only(top: AppLayoutConfig.pageVentilationSpacing),
        child: AppValueInputComponent(
            type: ValueType.humidity,
            icon: AppIcons.humidity,
            hint: AppL18nConfig.get(context).ventilation_values_outside_humidity,
            onChanged: (s, v) {
              setState(() {
                _humidityOut = int.tryParse(s ?? "");
                _humidityOutValid = v;
              });
            },
            invalidHint: AppL18nConfig.get(context).ventilation_invalid_humidity));
  }

  Step _thirdStep() {
    return Step(
      title: _getStepTitle(AppL18nConfig.get(context).ventilation_values_inside),
      content: Column(
        children: [_thirdStepTemperatureInput(), _thirdStepHumidityInput()],
      ),
      isActive: _currentStep == 2,
      state: _currentStep == 2
          ? StepState.editing
          : _currentStep > 2
              ? StepState.complete
              : StepState.disabled,
    );
  }

  Widget _thirdStepTemperatureInput() {
    return AppValueInputComponent(
        type: ValueType.temperature,
        hint: AppL18nConfig.get(context).ventilation_values_inside_temperature,
        icon: Icons.thermostat,
        onChanged: (s, v) {
          setState(() {
            _tempIn = double.tryParse(s!.replaceAll(",", "."));
            _tempInValid = v;
          });
        },
        invalidHint: AppL18nConfig.get(context).ventilation_invalid_temperature);
  }

  Widget _thirdStepHumidityInput() {
    return Padding(
      padding: const EdgeInsets.only(top: AppLayoutConfig.pageVentilationSpacing),
      child: AppValueInputComponent(
          type: ValueType.humidity,
          icon: AppIcons.humidity,
          hint: AppL18nConfig.get(context).ventilation_values_inside_humidity,
          onChanged: (s, v) {
            setState(() {
              _humidityIn = int.tryParse(s ?? "");
              _humidityInValid = v;
            });
          },
          invalidHint: AppL18nConfig.get(context).ventilation_invalid_humidity),
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
