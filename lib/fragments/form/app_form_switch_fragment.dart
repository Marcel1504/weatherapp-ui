import 'package:flutter/material.dart';

class AppFormSwitchFragment extends StatefulWidget {
  final bool initial;
  final ValueChanged<bool>? onChanged;
  final String? title;
  final String? subtitle;

  const AppFormSwitchFragment({super.key, required this.initial, this.onChanged, this.title, this.subtitle});

  @override
  State<AppFormSwitchFragment> createState() => _AppFormSwitchFragmentState();
}

class _AppFormSwitchFragmentState extends State<AppFormSwitchFragment> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch(
          value: _isSwitched,
          onChanged: (v) {
            _isSwitched = v;
            if (widget.onChanged != null) {
              widget.onChanged!.call(v);
            }
          }),
      title: widget.title != null ? Text(widget.title!) : null,
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
    );
  }
}
