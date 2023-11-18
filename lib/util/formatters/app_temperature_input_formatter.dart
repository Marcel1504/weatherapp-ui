import 'package:flutter/services.dart';

class AppTemperatureInputFormatter implements TextInputFormatter {
  final RegExp _regExp = RegExp(r"^[+-]?(\d{1,3}[\.,](\d{1,2})?)?$|^[+-]?(\d{1,3})?$", caseSensitive: false);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regExp.hasMatch(newValue.text) || newValue.text.isEmpty) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
