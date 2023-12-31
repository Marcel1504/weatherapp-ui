import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/dialog/app_dialog_component.dart';

class AppDatePickerService {
  Future<DateTime?> showAppDatePicker(BuildContext context, {DateTime? initial}) {
    return showDatePicker(
        context: context,
        initialDate: initial ?? DateTime.now(),
        firstDate: DateTime(2018, 1, 1),
        builder: (BuildContext context, Widget? child) => Theme(data: _getDatePickerTheme(context), child: child!),
        lastDate: DateTime.now());
  }

  void showAppYearPicker(BuildContext context, Function(DateTime?) selected, {DateTime? initial}) {
    showDialog(
        context: context,
        builder: (context) => AppDialogComponent(
              height: 300,
              width: 300,
              child: YearPicker(
                currentDate: initial,
                firstDate: DateTime(2018, 1, 1),
                onChanged: (DateTime y) {
                  selected.call(y);
                  Navigator.pop(context);
                },
                lastDate: DateTime.now(),
                selectedDate: initial ?? DateTime.now(),
              ),
            ));
  }

  ThemeData _getDatePickerTheme(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.secondary;
    Color onPrimary = Theme.of(context).colorScheme.onSecondary;
    return Theme.of(context)
        .copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(primary: primary, onPrimary: onPrimary));
  }
}
