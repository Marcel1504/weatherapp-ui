import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppHeaderTextComponent extends StatelessWidget {
  final String title;

  const AppHeaderTextComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing * 1.5, bottom: AppLayoutConfig.defaultSpacing),
      child: Text(title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: AppLayoutConfig.defaultTextHeadlineFontSize, color: Theme.of(context).colorScheme.secondary)),
    );
  }
}
