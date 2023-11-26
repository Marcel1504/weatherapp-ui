import 'package:flutter/material.dart';
import 'package:weatherapp_ui/services/backend/summary/single/app_single_summary_backend_service.dart';

abstract class AppSingleSummaryProvider<T> extends ChangeNotifier {
  T? _latest;
  bool _loading = false;
  bool _reset = false;
  String? _stationCode;

  void loadLatestByStationCode(BuildContext context, String? stationCode, {bool notifyLoadStart = false}) {
    if (!_loading && stationCode != null && (stationCode != _stationCode || _reset)) {
      _loading = true;
      _stationCode = stationCode;
      if (notifyLoadStart) {
        notifyListeners();
      }
      getBackendService().getLatest(stationCode).then((data) {
        _latest = data;
        _loading = false;
        _reset = false;
        notifyListeners();
      });
    }
  }

  @protected
  AppSingleSummaryBackendService<T> getBackendService();

  void markForReset() {
    _reset = true;
  }

  bool get loading => _loading;

  T? get latest => _latest;
}
