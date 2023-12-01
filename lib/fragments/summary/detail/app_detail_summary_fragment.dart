import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chip/app_choice_chip_list_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppDetailSummaryFragment extends StatefulWidget {
  final List<String> chartTitles;
  final List<Widget> chartWidgets;

  const AppDetailSummaryFragment({super.key, required this.chartTitles, required this.chartWidgets});

  @override
  State<AppDetailSummaryFragment> createState() => _AppDetailSummaryFragmentState();
}

class _AppDetailSummaryFragmentState extends State<AppDetailSummaryFragment> {
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
    return Padding(
      padding: const EdgeInsets.only(
          top: AppLayoutConfig.defaultSpacing,
          left: AppLayoutConfig.defaultSpacing,
          right: AppLayoutConfig.defaultSpacing),
      child:
          AppChoiceChipListComponent(titles: widget.chartTitles, onTap: (i) => setState(() => _selectedChartIndex = i)),
    );
  }

  Widget _body() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(
          bottom: AppLayoutConfig.defaultSpacing,
          left: AppLayoutConfig.defaultSpacing,
          right: AppLayoutConfig.defaultSpacing),
      child: widget.chartWidgets[_selectedChartIndex],
    ));
  }
}
