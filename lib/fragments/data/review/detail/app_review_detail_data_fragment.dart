import 'package:flutter/material.dart';
import 'package:weatherapp_ui/fragments/chip/app_choice_chip_list_fragment.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppReviewDetailDataFragment extends StatefulWidget {
  final List<String> chartTitles;
  final List<Widget> chartWidgets;

  const AppReviewDetailDataFragment(
      {super.key, required this.chartTitles, required this.chartWidgets});

  @override
  State<AppReviewDetailDataFragment> createState() =>
      _AppReviewDetailDataFragmentState();
}

class _AppReviewDetailDataFragmentState
    extends State<AppReviewDetailDataFragment> {
  int _selectedChartIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [_header(), _body()],
      ),
    );
  }

  Widget _header() {
    AppLayoutService layoutService = AppLayoutService();
    return Padding(
      padding: EdgeInsets.only(
          top: layoutService.betweenItemPadding(),
          left: layoutService.betweenItemPadding(),
          right: layoutService.betweenItemPadding()),
      child: AppChoiceChipListFragment(
          titles: widget.chartTitles,
          onTap: (i) => setState(() => _selectedChartIndex = i)),
    );
  }

  Widget _body() {
    AppLayoutService layoutService = AppLayoutService();
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(
          bottom: layoutService.betweenItemPadding(),
          left: layoutService.betweenItemPadding(),
          right: layoutService.betweenItemPadding()),
      child: widget.chartWidgets[_selectedChartIndex],
    ));
  }
}
