import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/services/api/station/app_station_api_service.dart';

class AppStationProvider extends ChangeNotifier {
  AppStationApiService appStationApiService = AppStationApiService();

  List<AppStationResponseDto> _stations = [];
  AppStationResponseDto? _selectedStation;
  bool _isLoading = false;
  bool _hasLoadingError = false;

  void load({bool notifyLoadStart = false}) {
    if (_isLoading) return;
    _isLoading = true;
    _hasLoadingError = false;
    if (notifyLoadStart) notifyListeners();
    appStationApiService.getAllStations().then((stations) {
      _stations = stations?.list ?? [];
      if (_stations.isNotEmpty) {
        _selectedStation = _stations[0];
      }
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      _hasLoadingError = true;
      notifyListeners();
    });
  }

  List<AppStationResponseDto> get stations => _stations;

  bool get hasLoadingError => _hasLoadingError;

  bool get isLoading => _isLoading;

  AppStationResponseDto? get selectedStation => _selectedStation;
}
