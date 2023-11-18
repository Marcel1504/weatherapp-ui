import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/dto/request/data/export/app_export_data_request_dto.dart';
import 'package:weatherapp_ui/dto/response/status/app_status_response_dto.dart';
import 'package:weatherapp_ui/services/api/data/export/app_export_data_api_service.dart';

abstract class AppExportDataProvider extends ChangeNotifier {
  AppStatusResponseDto? _response;
  bool _loading = false;
  String? _startDay;
  String? _endDay;

  void exportDataForStationCode(
      {String? stationCode, String? startDay, String? endDay, AppExportDataRequestDto? request}) async {
    if (!_loading) {
      _loading = true;
      getApiService().export(stationCode, startDay, endDay, request).then((r) {
        _response = r;
        _startDay = startDay;
        _endDay = endDay;
        _loading = false;
        notifyListeners();
      }).catchError((e) {
        _loading = false;
        notifyListeners();
      });
    }
  }

  @protected
  AppExportDataApiService getApiService();

  String? get endDay => _endDay;

  String? get startDay => _startDay;

  bool? get loading => _loading;

  AppStatusResponseDto? get response => _response;
}
