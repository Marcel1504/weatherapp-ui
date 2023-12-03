import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppInputComponent extends StatelessWidget {
  final double size;
  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onInputChanged;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final String? suffix;

  const AppInputComponent(
      {super.key,
      this.onInputChanged,
      this.inputType = TextInputType.text,
      this.validator,
      this.size = AppLayoutConfig.defaultInputSize,
      this.hint,
      this.controller,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size),
          child: TextFormField(
            validator: validator,
            keyboardType: inputType,
            onChanged: (t) => onInputChanged?.call(t),
            controller: controller,
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: size * 0.38),
            decoration: _getTextFieldDecoration(context),
          ),
        ));
  }

  InputDecoration _getTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        errorBorder: _getErrorBorder(context),
        focusedErrorBorder: _getFocusedErrorBorder(context),
        enabledBorder: _getEnabledBorder(context),
        focusedBorder: _getFocusedBorder(context),
        suffix: suffix != null ? Text(suffix!) : null,
        errorStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.error, fontSize: size * 0.38),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: size * 0.38),
        contentPadding: EdgeInsets.symmetric(vertical: size * 0.20, horizontal: size * 0.5));
  }

  InputBorder _getErrorBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            width: AppLayoutConfig.defaultInputBorderWidth,
            color: Theme.of(context).colorScheme.error.withOpacity(0.5)),
        borderRadius: BorderRadius.circular((size * 0.5) + (2 * AppLayoutConfig.defaultInputBorderWidth)));
  }

  InputBorder _getFocusedErrorBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide:
            BorderSide(width: AppLayoutConfig.defaultInputBorderWidth, color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular((size * 0.5) + (2 * AppLayoutConfig.defaultInputBorderWidth)));
  }

  InputBorder _getEnabledBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            width: AppLayoutConfig.defaultInputBorderWidth,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
        borderRadius: BorderRadius.circular((size * 0.5) + (2 * AppLayoutConfig.defaultInputBorderWidth)));
  }

  InputBorder _getFocusedBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide:
            BorderSide(width: AppLayoutConfig.defaultInputBorderWidth, color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular((size * 0.5) + (2 * AppLayoutConfig.defaultInputBorderWidth)));
  }
}
