import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/tooltip/app_tooltip_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final String? tooltip;
  final AppButtonTypeEnum type;
  final double size;
  final Widget Function(BuildContext context, Color foreground, Color background) builder;

  const AppButtonComponent(
      {super.key,
      this.onTap,
      this.tooltip,
      this.type = AppButtonTypeEnum.normal,
      this.size = AppLayoutConfig.buttonDefaultSize,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    Color background = _getBackgroundColor(context);
    Color foreground = _getForegroundColor(context);

    return AppTooltipComponent(
      message: tooltip,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(size / 2),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size / 2),
          child: Padding(
            padding: EdgeInsets.all(size / 4),
            child: builder.call(context, foreground, background),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    Color color;
    switch (type) {
      case AppButtonTypeEnum.primary:
        color = Theme.of(context).colorScheme.primary;
        break;
      case AppButtonTypeEnum.secondary:
        color = Color.alphaBlend(
            Theme.of(context).colorScheme.secondary.withOpacity(0.1), Theme.of(context).colorScheme.surface);
        break;
      case AppButtonTypeEnum.normal:
        color = Theme.of(context).colorScheme.surface;
        break;
      case AppButtonTypeEnum.transparent:
        return Colors.transparent;
    }
    return onTap != null ? color : color.withOpacity(0.1);
  }

  Color _getForegroundColor(BuildContext context) {
    Color color;
    switch (type) {
      case AppButtonTypeEnum.primary:
        color = Theme.of(context).colorScheme.onPrimary;
        break;
      case AppButtonTypeEnum.secondary:
        color = Theme.of(context).colorScheme.onSurface;
        break;
      case AppButtonTypeEnum.normal:
        color = Theme.of(context).colorScheme.onSurface;
        break;
      case AppButtonTypeEnum.transparent:
        color = Theme.of(context).colorScheme.onSurface;
        break;
    }
    return onTap != null ? color : color.withOpacity(0.1);
  }
}
