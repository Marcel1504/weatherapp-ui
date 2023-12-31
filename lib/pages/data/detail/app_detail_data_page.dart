import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/scaffold/app_scaffold_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppDetailDataPage extends StatelessWidget {
  final Widget child;
  final String? title;

  const AppDetailDataPage({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      appBar: _appBar(context),
      body: child,
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
      titleTextStyle:
          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
    );
  }
}
