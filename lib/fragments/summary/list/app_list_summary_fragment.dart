import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/loading/app_loading_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/app_aggregation_summary_provider.dart';

class AppListSummaryFragment extends StatefulWidget {
  final AppStationResponseDto? station;
  final Widget Function(dynamic) itemBuilder;
  final AppAggregationSummaryProvider provider;

  const AppListSummaryFragment({super.key, this.station, required this.itemBuilder, required this.provider});

  @override
  State<AppListSummaryFragment> createState() => _AppListSummaryFragmentState();
}

class _AppListSummaryFragmentState extends State<AppListSummaryFragment> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      ScrollPosition position = _scrollController.position;
      if (position.atEdge && position.pixels != 0) {
        widget.provider.loadNext(notifyLoadStart: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.provider.loadInitialByStationCode(widget.station?.code);
    return ListView(
      controller: _scrollController,
      children: [
        ...widget.provider.data.map((d) => widget.itemBuilder.call(d)).mapIndexed((index, item) => Column(
              children: [item, index < widget.provider.data.length - 1 ? const Divider() : Container()],
            )),
        widget.provider.loading
            ? const Padding(
                padding: EdgeInsets.all(AppLayoutConfig.defaultSpacing),
                child: AppLoadingComponent(
                  size: 30,
                ),
              )
            : Container()
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
