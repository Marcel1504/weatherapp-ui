import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chip/app_choice_chip_component.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppChoiceChipListComponent extends StatefulWidget {
  final List<String> titles;
  final Function(int) onTap;
  final bool primary;

  const AppChoiceChipListComponent({super.key, required this.titles, required this.onTap, this.primary = true});

  @override
  State<AppChoiceChipListComponent> createState() => _AppChoiceChipListComponentState();
}

class _AppChoiceChipListComponentState extends State<AppChoiceChipListComponent> {
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

    return widget.titles.length > 1
        ? Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: _chips()
                      .map((c) => Padding(
                    padding: EdgeInsets.only(
                                right: layoutService.betweenItemPadding(),
                                bottom: layoutService.betweenItemPadding() * 1.2),
                            child: c,
                          ))
                      .toList()),
            ),
          )
        : Container();
  }

  List<Widget> _chips() {
    return widget.titles
        .mapIndexed((index, title) => AppChoiceChipComponent(
              selected: _selectedIndex == index,
              primary: widget.primary,
              text: title,
              onTap: () => setState(() {
                _selectedIndex = index;
                widget.onTap.call(_selectedIndex);
              }),
            ))
        .toList();
  }
}
