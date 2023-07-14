import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigurationService {
  bool isMobile() {
    return isAndroid() || isIOS();
  }

  bool isIOS() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool isAndroid() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  Future<void> _setBool(String property, bool value) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setBool(property, value);
  }

  Future<bool> _getBool(String property, {bool defaultValue = false}) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    bool? b = p.getBool(property);
    b ??= defaultValue;
    return b;
  }
}