import 'package:flutter/services.dart';

class AppHumidityInputFormatter implements TextInputFormatter {
  final RegExp _regExp = RegExp(r"(^[1-9][0-9]?$)|(^100$)", caseSensitive: false);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regExp.hasMatch(newValue.text) || newValue.text.isEmpty) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
