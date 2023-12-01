import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppTooltipComponent extends StatelessWidget {
  final String? message;
  final Widget? child;

  const AppTooltipComponent({super.key, this.message, this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message ?? "",
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppLayoutConfig.defaultBorderRadius),
          color: Theme.of(context).colorScheme.tertiary),
      waitDuration: const Duration(milliseconds: 500),
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onTertiary, fontSize: AppLayoutConfig.defaultTextBodyFontSize),
      child: child,
    );
  }
}
