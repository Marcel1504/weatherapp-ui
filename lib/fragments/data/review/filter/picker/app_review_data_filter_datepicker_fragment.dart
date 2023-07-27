import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppReviewDataFilterDatePickerFragment extends StatefulWidget {
  final String? title;
  final Function(DateTime?)? onSelected;
  final DateTime? initialDate;

  const AppReviewDataFilterDatePickerFragment(
      {super.key, this.onSelected, this.title, this.initialDate});

  @override
  State<AppReviewDataFilterDatePickerFragment> createState() =>
      _AppReviewDataFilterDatePickerFragmentState();
}

class _AppReviewDataFilterDatePickerFragmentState
    extends State<AppReviewDataFilterDatePickerFragment> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
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
                widget.title ?? "",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Text(
              AppTimeService().transformDateTime(context, _selected,
                      pattern: "dd. MMMM yyyy") ??
                  AppLocalizations.of(context)!.filter_title_no_day_selected,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
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
            action: () => setState(() => _selectDate(null)),
          )
        : Container();
  }

  void _showPicker() async {
    DateTime? now = DateTime.now();
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime.parse("2018-01-01"),
        lastDate: now);
    if (newDate != null) {
      setState(() => _selectDate(newDate));
    }
  }

  void _selectDate(DateTime? newDate) {
    setState(() {
      _selected = newDate;
      widget.onSelected?.call(_selected);
    });
  }
}
