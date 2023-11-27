import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppHeaderTextComponent extends StatelessWidget {
  final String title;

  const AppHeaderTextComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppLayoutService().betweenItemPadding() * 1.5, bottom: AppLayoutService().betweenItemPadding()),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: AppLayoutConfig.textHeaderFontSize, color: Theme.of(context).colorScheme.secondary)),
    );
  }
}
