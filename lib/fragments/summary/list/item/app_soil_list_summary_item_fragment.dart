import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/fragments/summary/list/item/app_list_summary_item_fragment.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';

class AppSoilListSummaryItemFragment extends AppListSummaryItemFragment<AppSoilAggregationSummaryResponseDto> {
  const AppSoilListSummaryItemFragment(
      {super.key,
      super.time,
      required super.timeInputPattern,
      required super.timeOutputPattern,
      super.onTap,
      super.data});

  @override
  Widget content(BuildContext context, String? title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppLayoutConfig.defaultSpacing),
          child: Text(
            title ?? "",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _temperatureDataItem(context, temperature: super.data?.temperature50cmAvg, subtitle: "50cm"),
            _temperatureDataItem(context, temperature: super.data?.temperature100cmAvg, subtitle: "100cm"),
            _temperatureDataItem(context, temperature: super.data?.temperature200cmAvg, subtitle: "200cm")
          ],
        )
      ],
    );
  }

  @override
  Color tapColor(BuildContext context) {
    return AppColorService().temperatureToColor(context, super.data?.temperature50cmAvg);
  }

  Widget _temperatureDataItem(BuildContext context, {double? temperature, String? subtitle}) {
    Color color = AppColorService().temperatureToColor(context, temperature);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppLayoutConfig.defaultSpacing * 0.5),
          child: Text(temperature?.toString() ?? "--",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: color, fontSize: AppLayoutConfig.listSummarySoilTemperatureFontSize)),
        ),
        Text(subtitle ?? "",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: AppLayoutConfig.defaultTextLabelFontSize))
      ],
    );
  }
}
