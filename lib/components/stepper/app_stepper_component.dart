import 'package:flutter/material.dart';

class AppStepperComponent extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final Function() onStepContinue;
  final Function() onStepCancel;
  final Widget Function(BuildContext, ControlsDetails)? controlsBuilder;

  const AppStepperComponent(
      {super.key,
      required this.steps,
      required this.currentStep,
      required this.onStepContinue,
      required this.onStepCancel,
      this.controlsBuilder});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color background = colorScheme.surface;
    Color onBackground = colorScheme.onBackground;
    Color primary = colorScheme.secondary;
    Color onPrimary = colorScheme.onSecondary;
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
                background: background, onBackground: onBackground, primary: primary, onPrimary: onPrimary)),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: currentStep,
          onStepContinue: onStepContinue,
          onStepCancel: onStepCancel,
          controlsBuilder: controlsBuilder,
          steps: steps,
        ));
  }
}
