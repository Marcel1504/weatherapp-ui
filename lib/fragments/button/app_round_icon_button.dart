import 'package:flutter/material.dart';

class AppRoundIconButtonComponent extends StatelessWidget {
  final IconData? icon;
  final Function? action;
  final bool primary;
  final int size;

  const AppRoundIconButtonComponent(
      {Key? key, this.icon, this.action, this.primary = true, this.size = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _getButtonColor(context),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: action != null ? () => action?.call() : null,
        borderRadius: BorderRadius.circular(size.toDouble()),
        child: Padding(
          padding: EdgeInsets.all(size / 2),
          child: Icon(
            icon,
            size: size.toDouble(),
            color: _getIconColor(context),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    Color base = primary
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.surface;
    return action != null ? base : base.withOpacity(0.2);
  }

  Color _getIconColor(BuildContext context) {
    Color base = primary
        ? Theme.of(context).colorScheme.onSecondary
        : Theme.of(context).colorScheme.onSurface;
    return action != null ? base : base.withOpacity(0.2);
  }
}
