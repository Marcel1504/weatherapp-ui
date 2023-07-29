import 'package:flutter/material.dart';

class AppChoiceChipFragment extends StatelessWidget {
  final String? text;
  final bool selected;
  final Function()? onTap;

  const AppChoiceChipFragment(
      {super.key, this.text, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(text ?? "",
          style: TextStyle(
            color: Theme.of(context)
                .chipTheme
                .labelStyle!
                .color!
                .withOpacity(selected ? 1 : 0.7),
          )),
      selected: selected,
      onSelected: (_) => onTap?.call(),
    );
  }
}
