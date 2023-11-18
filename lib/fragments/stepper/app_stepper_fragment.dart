import 'package:flutter/material.dart';

class AppStepperFragment extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final Function() onStepContinue;
  final Function() onStepCancel;
  final Widget Function(BuildContext, ControlsDetails)? controlsBuilder;

  const AppStepperFragment(
      {super.key,
      required this.steps,
      required this.currentStep,
      required this.onStepContinue,
      required this.onStepCancel,
      this.controlsBuilder});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Theme(
        data: Theme.of(context).copyWith(colorScheme: colorScheme.copyWith(background: colorScheme.surface)),
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
