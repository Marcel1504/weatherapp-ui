import 'package:flutter/material.dart';
import 'package:weatherapp_ui/fragments/dialog/app_dialog_fragment.dart';

class AppDatePickerService {
  Future<DateTime?> showAppDatePicker(BuildContext context,
      {DateTime? initial}) {
    return showDatePicker(
        context: context,
        initialDate: initial ?? DateTime.now(),
        firstDate: DateTime(2018, 1, 1),
        lastDate: DateTime.now());
  }

  void showAppYearPicker(BuildContext context, Function(DateTime?) selected,
      {DateTime? initial}) {
    showDialog(
        context: context,
        builder: (context) => AppDialogFragment(
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
}
