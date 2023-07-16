import 'package:flutter/material.dart';
import 'package:weatherapp_ui/services/api/data/single/app_single_data_api_service.dart';

abstract class AppSingleDataProvider<T> extends ChangeNotifier {
  T? _latest;
  bool _loading = false;
  String? _stationCode;

  void loadLatestByStationCode(BuildContext context, String? stationCode,
      {notifyLoadStart = false}) {
    if (!_loading && stationCode != null && stationCode != _stationCode) {
      _loading = true;
      _stationCode = stationCode;
      if (notifyLoadStart) {
        notifyListeners();
      }
      getApiService().getLatest(stationCode).then((data) {
        _latest = data;
        _loading = false;
        notifyListeners();
      });
    }
  }

  @protected
  AppSingleDataApiService<T> getApiService();

  bool get loading => _loading;

  T? get latest => _latest;
}
