import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/services/datepicker/app_datepicker_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppPickerYearFragment extends StatefulWidget {
  final Function(DateTime?)? onSelected;
  final DateTime? initialYear;

  const AppPickerYearFragment({super.key, this.onSelected, this.initialYear});

  @override
  State<AppPickerYearFragment> createState() => _AppPickerYearFragmentState();
}

class _AppPickerYearFragmentState extends State<AppPickerYearFragment> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.headlineSmall!;
    return ListTile(
      onTap: () => _showPicker(),
      leading: Icon(
        Icons.calendar_month,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_text(style), _clearButton(style)]),
    );
  }

  Widget _text(TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppLayoutService().betweenItemPadding() * 0.5),
          child: Text(
            AppLocalizations.of(context)!.filter_value_year,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Text(
          AppTimeService().transformDateTime(context, _selected, pattern: "yyyy") ??
              AppLocalizations.of(context)!.filter_title_no_year_selected,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _clearButton(TextStyle style) {
    return _selected != null
        ? AppRoundIconButtonComponent(
            primary: false,
            icon: Icons.clear,
            size: (style.fontSize! * 1).toInt(),
            action: () => setState(() => _selectYear(null)),
          )
        : Container();
  }

  void _showPicker() {
    AppDatePickerService().showAppYearPicker(context, (d) => _selectYear(d), initial: _selected);
  }

  void _selectYear(DateTime? newYear) {
    setState(() {
      _selected = newYear;
      widget.onSelected?.call(_selected);
    });
  }
}
