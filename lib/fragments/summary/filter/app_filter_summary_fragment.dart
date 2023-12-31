import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppFilterSummaryFragment extends StatelessWidget {
  final String? title;
  final bool selected;
  final IconData? icon;
  final VoidCallback? onTap;

  const AppFilterSummaryFragment({super.key, this.title, this.selected = false, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextBodyFontSize);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap?.call(),
        child: Padding(
          padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_text(style), _selectionIcon(context, style)],
          ),
        ),
      ),
    );
  }

  Widget _text(TextStyle style) {
    return Row(
      children: [
        icon != null
            ? Padding(
          padding: const EdgeInsets.only(right: AppLayoutConfig.defaultSpacing * 0.5),
                child: Icon(
                  icon,
                  color: style.color!.withOpacity(0.7),
                  size: style.fontSize! * 1.2,
                ),
              )
            : Container(),
        Text(
          title ?? "",
          style: style,
        ),
      ],
    );
  }

  Widget _selectionIcon(BuildContext context, TextStyle style) {
    return selected
        ? Icon(
            Icons.check,
            size: style.fontSize! * 1.5,
            color: Theme.of(context).colorScheme.primary,
          )
        : Icon(
            null,
            size: style.fontSize! * 1.5,
            color: Theme.of(context).colorScheme.primary,
          );
  }
}
