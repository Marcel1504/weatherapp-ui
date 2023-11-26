import 'package:flutter/material.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/fragments/data/review/list/item/app_review_data_list_item_fragment.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/themes/app_icons.dart';

class AppWeatherReviewDataListItemFragment
    extends AppReviewDataListItemFragment<AppWeatherAggregationSummaryResponseDto> {
  const AppWeatherReviewDataListItemFragment(
      {super.key,
      super.time,
      required super.timeInputPattern,
      required super.timeOutputPattern,
      super.onTap,
      super.data});

  @override
  Widget content(BuildContext context, String? title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_temperatureBox(context), _infoBox(context, title)],
    );
  }

  @override
  Color tapColor(BuildContext context) {
    return AppColorService().temperatureToColor(context, super.data?.temperatureAvg);
  }

  Widget _temperatureBox(BuildContext context) {
    AppWeatherAggregationSummaryResponseDto? weather = super.data;
    return Row(
      children: [
        _temperatureDataItem(context,
            temperature: weather?.temperatureAvg,
            width: 80,
            styleBase: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 30)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: AppLayoutService().betweenItemPadding() * 0.5),
              child: _temperatureDataItem(context,
                  temperature: weather?.temperatureMax,
                  icon: Icons.arrow_upward,
                  styleBase: Theme.of(context).textTheme.headlineSmall),
            ),
            _temperatureDataItem(context,
                temperature: weather?.temperatureMin,
                icon: Icons.arrow_downward,
                styleBase: Theme.of(context).textTheme.headlineSmall),
          ],
        )
      ],
    );
  }

  Widget _infoBox(BuildContext context, String? title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppLayoutService().betweenItemPadding() * 0.5),
          child: Text(title ?? "", style: Theme.of(context).textTheme.headlineMedium),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: AppLayoutService().betweenItemPadding() * 0.5),
          child: _windDataItem(context),
        ),
        _rainTotalDataItem(context)
      ],
    );
  }

  Widget _windDataItem(BuildContext context) {
    AppWeatherAggregationSummaryResponseDto? weather = super.data;
    Color color =
        Color.alphaBlend(const Color.fromRGBO(111, 111, 111, 0.7), Theme.of(context).colorScheme.onBackground);
    String text = weather?.windMax != null && weather?.windMax != 0 ? "${weather?.windMax} km/h" : "";
    IconData? icon = weather?.windMax != null && weather?.windMax != 0 ? AppIcons.wind : null;
    return _dataItem(context,
        data: text, icon: icon, styleBase: Theme.of(context).textTheme.headlineSmall!.copyWith(color: color));
  }

  Widget _rainTotalDataItem(BuildContext context) {
    AppWeatherAggregationSummaryResponseDto? weather = super.data;
    Color color = Color.alphaBlend(const Color.fromRGBO(0, 175, 255, 0.7), Theme.of(context).colorScheme.onBackground);
    String text = weather?.rainTotal != null && weather?.rainTotal != 0 ? "${weather?.rainTotal} l/m²" : "";
    IconData? icon = weather?.rainTotal != null && weather?.rainTotal != 0 ? AppIcons.rain : null;
    return _dataItem(context,
        data: text, icon: icon, styleBase: Theme.of(context).textTheme.headlineSmall!.copyWith(color: color));
  }

  Widget _temperatureDataItem(BuildContext context,
      {double? temperature, double? width, IconData? icon, TextStyle? styleBase}) {
    Color color = AppColorService().temperatureToColor(context, temperature);
    styleBase = styleBase?.copyWith(color: color);
    return _dataItem(context, data: temperature.toString(), icon: icon, width: width, styleBase: styleBase);
  }

  Widget _dataItem(BuildContext context, {String? data, double? width, IconData? icon, TextStyle? styleBase}) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          icon != null
              ? Padding(
                  padding: EdgeInsets.only(right: styleBase!.fontSize! * 0.5),
                  child: Icon(
                    icon,
                    color: styleBase.color,
                    size: styleBase.fontSize,
                  ),
                )
              : Container(),
          Text(
            data ?? "--",
            style: styleBase,
          )
        ],
      ),
    );
  }
}
