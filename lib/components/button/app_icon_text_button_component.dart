import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppIconTextButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? text;
  final String? tooltip;
  final AppButtonTypeEnum type;
  final double size;

  const AppIconTextButtonComponent(
      {super.key,
      this.onTap,
      this.icon,
      this.text,
      this.size = AppLayoutConfig.buttonDefaultSize,
      this.tooltip,
      this.type = AppButtonTypeEnum.normal});

  @override
  Widget build(BuildContext context) {
    return AppButtonComponent(
        size: size,
        tooltip: tooltip,
        type: type,
        onTap: onTap,
        builder: (context, foreground, background) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon != null ? _getIcon(context, foreground) : Container(), _getText(context, foreground)],
            ));
  }

  Widget _getIcon(BuildContext context, Color foreground) {
    return Padding(
      padding: EdgeInsets.only(left: size / 6),
      child: Icon(
        icon,
        color: foreground,
        size: size / 2,
      ),
    );
  }

  Widget _getText(BuildContext context, Color foreground) {
    return Padding(
        padding: EdgeInsets.only(right: size / 6, left: size / 6),
        child: Text(text ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: size / 2.5,
                  color: foreground,
                )));
  }
}
