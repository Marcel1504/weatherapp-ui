import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp_ui/util/formatters/app_humidity_input_formatter.dart';
import 'package:weatherapp_ui/util/formatters/app_temperature_input_formatter.dart';

class AppFormFieldFragment extends StatelessWidget {
  final String? hint;
  final IconData? icon;
  final String? suffix;
  final TextInputType type;
  final FilterType filter;
  final Function(String?, bool) onChanged;
  final bool Function(String?) validation;
  final String? invalidHint;

  const AppFormFieldFragment(
      {super.key,
      this.hint,
      this.icon,
      this.suffix,
      required this.type,
      required this.filter,
      required this.onChanged,
      required this.validation,
      this.invalidHint});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon ?? Icons.text_fields,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
      title: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
            inputFormatters: _getFormatters(),
            onChanged: (v) => onChanged(v, validation.call(v)),
            validator: (v) => !validation.call(v) ? invalidHint : null,
            keyboardType: type,
            decoration: InputDecoration(
                suffix: suffix != null ? Text(suffix!) : null,
                hintText: hint ?? "",
                hintStyle: Theme.of(context).textTheme.bodySmall)),
      ),
    );
  }

  List<TextInputFormatter> _getFormatters() {
    switch (filter) {
      case FilterType.TEMPERATURE:
        return [AppTemperatureInputFormatter()];
      case FilterType.HUMIDITY:
        return [AppHumidityInputFormatter()];
      case FilterType.NONE:
      default:
        return [];
    }
  }
}

enum FilterType { TEMPERATURE, HUMIDITY, NONE }
