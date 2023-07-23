import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/providers/data/summary/app_summary_data_provider.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppReviewDataListFragment extends StatefulWidget {
  final AppStationResponseDto? station;
  final Widget Function(dynamic) itemBuilder;
  final AppSummaryDataProvider provider;

  const AppReviewDataListFragment(
      {super.key,
      this.station,
      required this.itemBuilder,
      required this.provider});

  @override
  State<AppReviewDataListFragment> createState() =>
      _AppReviewDataListFragmentState();
}

class _AppReviewDataListFragmentState extends State<AppReviewDataListFragment> {
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
        ...widget.provider.data
            .map((d) => widget.itemBuilder.call(d))
            .mapIndexed((index, item) => Column(
                  children: [
                    item,
                    index < widget.provider.data.length - 1
                        ? const Divider()
                        : Container()
                  ],
                )),
        widget.provider.loading
            ? Padding(
                padding:
                    EdgeInsets.all(AppLayoutService().betweenItemPadding()),
                child: const AppLoadingFragment(
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
