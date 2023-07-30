import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/fragments/chip/app_choice_chip_fragment.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppChoiceChipListFragment extends StatefulWidget {
  final List<String> titles;
  final Function(int) onTap;

  const AppChoiceChipListFragment(
      {super.key, required this.titles, required this.onTap});

  @override
  State<AppChoiceChipListFragment> createState() =>
      _AppChoiceChipListFragmentState();
}

class _AppChoiceChipListFragmentState extends State<AppChoiceChipListFragment> {
  late ScrollController _scrollController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();

    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
            children: _chips()
                .map((c) => Padding(
                      padding: EdgeInsets.only(
                          right: layoutService.betweenItemPadding(),
                          bottom: layoutService.betweenItemPadding()),
                      child: c,
                    ))
                .toList()),
      ),
    );
  }

  List<Widget> _chips() {
    return widget.titles
        .mapIndexed((index, title) => AppChoiceChipFragment(
              selected: _selectedIndex == index,
              text: title,
              onTap: () => setState(() {
                _selectedIndex = index;
                widget.onTap.call(_selectedIndex);
              }),
            ))
        .toList();
  }
}
