import 'package:flutter/material.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppHeaderTextFragment extends StatelessWidget {
  final String title;

  const AppHeaderTextFragment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppLayoutService().betweenItemPadding() * 1.5, bottom: AppLayoutService().betweenItemPadding()),
      child: Text(title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Color.alphaBlend(
                  Theme.of(context).colorScheme.primary.withOpacity(0.7), Theme.of(context).colorScheme.onBackground))),
    );
  }
}
