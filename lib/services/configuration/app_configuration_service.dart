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

  Future<void> saveSelectedStationCode(String code) {
    return _setString("selectedStationCode", code);
  }

  Future<String?> getSelectedStationCode() {
    return _getString("selectedStationCode");
  }

  Future<void> saveWelcomeInfoShown() {
    return _setBool("welcomeInfoShown", true);
  }

  Future<bool?> getWelcomeInfoShown() {
    return _getBool("welcomeInfoShown");
  }

  Future<void> _setString(String property, String value) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setString(property, value);
  }

  Future<String?> _getString(String property) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String? b = p.getString(property);
    return b;
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
