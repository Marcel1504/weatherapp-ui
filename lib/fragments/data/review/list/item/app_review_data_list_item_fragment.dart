import 'package:flutter/material.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

abstract class AppReviewDataListItemFragment<DATA> extends StatelessWidget {
  final String? time;
  final String timeInputPattern;
  final String timeOutputPattern;
  final DATA? data;
  final VoidCallback? onTap;

  const AppReviewDataListItemFragment(
      {super.key, this.time, required this.timeInputPattern, required this.timeOutputPattern, this.onTap, this.data});

  @override
  Widget build(BuildContext context) {
    String? title = AppTimeService()
        .transformTimeString(context, time, inputPattern: timeInputPattern, outputPattern: timeOutputPattern);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: tapColor(context).withOpacity(0.1),
        highlightColor: tapColor(context).withOpacity(0.1),
        onTap: () => onTap?.call(),
        child:
            Padding(padding: EdgeInsets.all(AppLayoutService().betweenItemPadding()), child: content(context, title)),
      ),
    );
  }

  @protected
  Widget content(BuildContext context, String? title);

  @protected
  Color tapColor(BuildContext context);
}
