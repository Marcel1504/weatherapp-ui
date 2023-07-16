import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/services/api/station/app_station_api_service.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';

class AppStationProvider extends ChangeNotifier {
  AppStationApiService stationApiService = AppStationApiService();
  AppConfigurationService configurationService = AppConfigurationService();

  List<AppStationResponseDto> _stations = [];
  AppStationResponseDto? _selectedStation;
  bool _isLoading = false;
  bool _hasLoadingError = false;

  void load({bool notifyLoadStart = false}) {
    if (_isLoading) return;
    _isLoading = true;
    _hasLoadingError = false;
    if (notifyLoadStart) {
      notifyListeners();
    }
    stationApiService.getAllStations().then((stations) {
      _stations = stations?.list ?? [];
      if (_stations.isNotEmpty) {
        configurationService.getSelectedStationCode().then((code) {
          _selectedStation = _stations.firstWhereOrNull((s) => s.code == code);
          _selectedStation ??= _stations[0];
          _isLoading = false;
          notifyListeners();
        });
      }
    }).catchError((error) {
      _isLoading = false;
      _hasLoadingError = true;
      notifyListeners();
    });
  }

  void changeSelectedStation(String? code) {
    if (code != null) {
      configurationService.saveSelectedStationCode(code).then((_) {
        _selectedStation = _stations.firstWhereOrNull((s) => s.code == code);
        notifyListeners();
      });
    }
  }

  List<AppStationResponseDto> get stations => _stations;

  bool get hasLoadingError => _hasLoadingError;

  bool get isLoading => _isLoading;

  AppStationResponseDto? get selectedStation => _selectedStation;
}
