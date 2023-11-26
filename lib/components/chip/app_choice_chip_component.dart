import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppChoiceChipComponent extends StatelessWidget {
  final String? text;
  final bool selected;
  final Function()? onTap;
  final bool primary;

  const AppChoiceChipComponent({super.key, this.text, required this.selected, this.onTap, this.primary = true});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? primary
              ? colorScheme.secondary
              : colorScheme.tertiary
          : colorScheme.surface,
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: InkWell(
        onTap: () => onTap?.call(),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Padding(
          padding: EdgeInsets.only(
              left: layoutService.betweenItemPadding() * 2,
              right: layoutService.betweenItemPadding() * 2,
              top: layoutService.betweenItemPadding() * 0.5,
              bottom: layoutService.betweenItemPadding() * 0.7),
          child: Text(
            text ?? "",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: AppLayoutConfig.chipFontSize,
                color: selected
                    ? primary
                        ? colorScheme.onSecondary
                        : colorScheme.onTertiary
                    : Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
