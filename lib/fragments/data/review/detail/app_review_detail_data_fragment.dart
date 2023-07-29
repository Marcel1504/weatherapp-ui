import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/fragments/chip/app_choice_chip_fragment.dart';
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: AppLayoutService().maxWidth()),
      child: Padding(
        padding: EdgeInsets.all(AppLayoutService().betweenItemPadding()),
        child: Row(
          children: [
            _headerChoices(),
          ],
        ),
      ),
    );
  }

  Widget _headerChoices() {
    List<AppChoiceChipFragment> choiceChips = widget.chartTitles
        .mapIndexed((index, title) => AppChoiceChipFragment(
              selected: _selectedChartIndex == index,
              text: title,
              onTap: () => setState(() => _selectedChartIndex = index),
            ))
        .toList();
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: choiceChips
                .map((c) => Padding(
                      padding: EdgeInsets.only(
                          right: AppLayoutService().betweenItemPadding()),
                      child: c,
                    ))
                .toList()),
      ),
    );
  }

  Widget _body() {
    AppLayoutService layoutService = AppLayoutService();
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(layoutService.betweenItemPadding()),
      child: widget.chartWidgets[_selectedChartIndex],
    ));
  }
}
