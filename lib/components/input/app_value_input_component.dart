import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/input/app_input_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppValueInputComponent extends StatefulWidget {
  final String? hint;
  final double size;
  final IconData? icon;
  final ValueType type;
  final Function(String?, bool) onChanged;
  final String? invalidHint;

  const AppValueInputComponent(
      {super.key,
      this.hint,
      this.icon,
      required this.type,
      required this.onChanged,
      this.size = AppLayoutConfig.defaultInputSize,
      this.invalidHint});

  @override
  State<AppValueInputComponent> createState() => _AppValueInputComponentState();
}

class _AppValueInputComponentState extends State<AppValueInputComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppInputComponent(
      size: widget.size,
      hint: widget.hint,
      controller: _controller,
      validator: (v) => !_determineValidator().call(v) ? widget.invalidHint : null,
      suffix: _determineSuffix(),
      onInputChanged: (t) => widget.onChanged.call(t, _determineValidator().call(t)),
    );
  }

  String? _determineSuffix() {
    switch (widget.type) {
      case ValueType.temperature:
        return "°C";
      case ValueType.humidity:
        return "%";
      case ValueType.email:
        return null;
    }
  }

  bool Function(String?) _determineValidator() {
    switch (widget.type) {
      case ValueType.temperature:
        return (v) => v != null && double.tryParse(v.replaceAll(",", ".")) != null;
      case ValueType.humidity:
        return (v) {
          if (v != null) {
            int? h = int.tryParse(v);
            return h != null && h >= 0 && h <= 100;
          }
          return false;
        };
      case ValueType.email:
        return (v) => v != null && v.isNotEmpty && RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v);
    }
  }
}

enum ValueType { temperature, humidity, email }
