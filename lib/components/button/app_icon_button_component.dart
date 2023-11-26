import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppIconButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? tooltip;
  final AppButtonTypeEnum type;
  final double size;

  const AppIconButtonComponent(
      {super.key,
      this.size = AppLayoutConfig.buttonDefaultSize,
      this.icon,
      this.onTap,
      this.tooltip,
      this.type = AppButtonTypeEnum.normal});

  @override
  Widget build(BuildContext context) {
    return AppButtonComponent(
        size: size,
        tooltip: tooltip,
        type: type,
        onTap: onTap,
        builder: (context, foreground, background) => Icon(icon, color: foreground, size: size / 2));
  }
}
