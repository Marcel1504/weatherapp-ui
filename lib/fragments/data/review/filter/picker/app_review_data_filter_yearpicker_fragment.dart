import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/fragments/dialog/app_dialog_fragment.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppReviewDataFilterYearPickerFragment extends StatefulWidget {
  final Function(DateTime?)? onSelected;
  final DateTime? initialYear;

  const AppReviewDataFilterYearPickerFragment(
      {super.key, this.onSelected, this.initialYear});

  @override
  State<AppReviewDataFilterYearPickerFragment> createState() =>
      _AppReviewDataFilterYearPickerFragmentState();
}

class _AppReviewDataFilterYearPickerFragmentState
    extends State<AppReviewDataFilterYearPickerFragment> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.headlineSmall!;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPicker(),
        child: Padding(
          padding: EdgeInsets.all(AppLayoutService().betweenItemPadding()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_text(style), _clearButton(style)],
          ),
        ),
      ),
    );
  }

  Widget _text(TextStyle style) {
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.only(right: AppLayoutService().betweenItemPadding()),
          child: Icon(
            Icons.calendar_month,
            size: Theme.of(context).textTheme.bodySmall!.fontSize! * 1.5,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: AppLayoutService().betweenItemPadding() * 0.5),
              child: Text(
                AppLocalizations.of(context)!.filter_value_year,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Text(
              AppTimeService()
                      .transformDateTime(context, _selected, pattern: "yyyy") ??
                  "Kein Jahr gewählt",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  void _yearSelected(DateTime newYear) {
    setState(() {
      _selected = newYear;
      widget.onSelected?.call(_selected);
    });
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
    DateTime? now = DateTime.now();
    showDialog(
        context: context,
        builder: (context) => AppDialogFragment(
              height: 300,
              width: 300,
              child: YearPicker(
                firstDate: DateTime.parse("2018-01-01"),
                onChanged: (DateTime newYear) {
                  _yearSelected(newYear);
                  Navigator.pop(context);
                },
                lastDate: now,
                selectedDate: _selected ?? DateTime.now(),
              ),
            ));
  }

  void _selectYear(DateTime? newYear) {
    setState(() {
      _selected = newYear;
      widget.onSelected?.call(_selected);
    });
  }
}
