import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/services/datepicker/app_datepicker_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppPickerYearComponent extends StatefulWidget {
  final Function(DateTime?)? onSelected;
  final DateTime? initialYear;

  const AppPickerYearComponent({super.key, this.onSelected, this.initialYear});

  @override
  State<AppPickerYearComponent> createState() => _AppPickerYearComponentState();
}

class _AppPickerYearComponentState extends State<AppPickerYearComponent> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialYear;
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
          padding: EdgeInsets.only(bottom: AppLayoutService().betweenItemPadding() * 0.5),
          child: Text(
            AppL18nConfig.get(context).filter_value_year,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.pickerTitleFontSize),
          ),
        ),
        Text(
          AppTimeService().transformDateTime(context, _selected, pattern: "yyyy") ??
              AppL18nConfig.get(context).filter_title_no_year_selected,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: AppLayoutConfig.pickerValueFontSize),
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
            onTap: () => setState(() => _selectYear(null)),
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
