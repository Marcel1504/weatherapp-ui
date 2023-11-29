import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:weatherapp_ui/components/button/app_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppLongTextButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? text;
  final String? tooltip;
  final AppButtonTypeEnum type;
  final double size;

  const AppLongTextButtonComponent(
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
      builder: (context, foreground, background) => _getText(context, foreground),
    );
  }

  Widget _getText(BuildContext context, Color foreground) {
    return Padding(
        padding: EdgeInsets.only(right: size / 6, left: size / 6),
        child: TextScroll(text ?? "",
            textAlign: TextAlign.center,
            mode: TextScrollMode.bouncing,
            pauseBetween: const Duration(seconds: 1),
            pauseOnBounce: const Duration(seconds: 1),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: size / 2.8,
                  color: foreground,
                )));
  }
}
