import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/services/datepicker/app_datepicker_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppPickerDayComponent extends StatefulWidget {
  final String? title;
  final Function(DateTime?)? onSelected;
  final DateTime? initialDate;

  const AppPickerDayComponent({super.key, this.onSelected, this.title, this.initialDate});

  @override
  State<AppPickerDayComponent> createState() => _AppPickerDayComponentState();
}

class _AppPickerDayComponentState extends State<AppPickerDayComponent> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showPicker(),
      leading: Icon(
        Icons.calendar_month,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_text(), _clearButton()]),
    );
  }

  Widget _text() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppLayoutConfig.defaultSpacing * 0.5),
          child: Text(
            widget.title ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextBodyFontSize),
          ),
        ),
        Text(
          AppTimeService().transformDateTime(context, _selected, pattern: "dd. MMMM yyyy") ??
              AppL18nConfig.get(context).filter_title_no_day_selected,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextLabelFontSize),
        ),
      ],
    );
  }

  Widget _clearButton() {
    return _selected != null
        ? AppIconButtonComponent(
            type: AppButtonTypeEnum.secondary,
            icon: Icons.clear,
            size: AppLayoutConfig.buttonPickerClearSize,
            onTap: () => setState(() => _selectDate(null)),
          )
        : Container();
  }

  void _showPicker() async {
    DateTime? newDate = await AppDatePickerService().showAppDatePicker(context, initial: _selected);
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
