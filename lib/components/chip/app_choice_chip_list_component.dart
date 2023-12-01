import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_chip_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppChoiceChipListComponent extends StatefulWidget {
  final List<String> titles;
  final Function(int) onTap;
  final bool primary;

  const AppChoiceChipListComponent({super.key, required this.titles, required this.onTap, this.primary = true});

  @override
  State<AppChoiceChipListComponent> createState() => _AppChoiceChipListComponentState();
}

class _AppChoiceChipListComponentState extends State<AppChoiceChipListComponent> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.titles.length > 1
        ? Scrollbar(
            controller: _scrollController,
            child:
                SingleChildScrollView(controller: _scrollController, scrollDirection: Axis.horizontal, child: _chips()))
        : Container();
  }

  Widget _chips() {
    return Row(
        children: widget.titles
            .mapIndexed((index, element) => _chipItem(element, index))
            .map((c) => Padding(
                  padding: const EdgeInsets.only(
                      right: AppLayoutConfig.defaultSpacing, bottom: AppLayoutConfig.defaultSpacing * 1.2),
                  child: c,
                ))
            .toList());
  }

  Widget _chipItem(String title, int index) {
    return AppChipButtonComponent(
      isSelected: _selectedIndex == index,
      isPrimary: widget.primary,
      text: title,
      size: 32,
      onTap: () => setState(() {
        _selectedIndex = index;
        widget.onTap.call(_selectedIndex);
      }),
    );
  }
}
