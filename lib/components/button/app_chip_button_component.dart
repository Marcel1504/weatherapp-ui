import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppChipButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final String? tooltip;
  final bool isSelected;
  final bool isPrimary;
  final double size;

  const AppChipButtonComponent(
      {super.key,
      this.onTap,
      this.text,
      this.size = AppLayoutConfig.defaultButtonSize,
      this.tooltip,
      this.isSelected = false,
      this.isPrimary = true});

  @override
  Widget build(BuildContext context) {
    return AppButtonComponent(
        size: size,
        spacingRatio: 0.1,
        tooltip: tooltip,
        type: isSelected
            ? isPrimary
                ? AppButtonTypeEnum.primary
                : AppButtonTypeEnum.tertiary
            : AppButtonTypeEnum.normal,
        onTap: onTap,
        builder: (context, foreground, background) => _getText(context, foreground));
  }

  Widget _getText(BuildContext context, Color foreground) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size * 0.5),
      child: Text(text ?? "",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: size * 0.55,
                color: foreground,
              )),
    );
  }
}
