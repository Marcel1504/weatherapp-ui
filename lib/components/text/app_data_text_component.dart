import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppDataTextComponent extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final String? value;
  final String? valueSuffix;

  const AppDataTextComponent({super.key, this.iconData, this.title, this.value, this.valueSuffix});

  @override
  Widget build(BuildContext context) {
    TextStyle valueStyle =
        Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: AppLayoutConfig.textDataValueFontSize);
    AppLayoutService layoutService = AppLayoutService();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: layoutService.betweenItemPadding() * 0.5),
              child: Icon(
                iconData,
                size: valueStyle.fontSize! * 1.2,
                color: valueStyle.color,
              ),
            ),
            Text(
              "$value $valueSuffix",
              style: valueStyle,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutService.betweenItemPadding() * 0.5),
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: AppLayoutConfig.textDataTitleFontSize),
          ),
        ),
      ],
    );
  }
}