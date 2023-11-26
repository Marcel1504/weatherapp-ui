import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_media_response_dto.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/models/app_file_model.dart';
import 'package:weatherapp_ui/services/backend/station/app_station_backend_service.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';

class AppStationProvider extends ChangeNotifier {
  AppStationBackendService stationBackendService = AppStationBackendService();
  AppConfigurationService configurationService = AppConfigurationService();

  List<AppStationResponseDto> _stations = [];
  AppStationResponseDto? _selectedStation;
  bool _isLoading = false;
  bool _hasLoadingError = false;
  AppFileModel? _selectedStationMediaFileLatest;
  AppFileModel? _selectedStationMediaFileReview;

  void load({bool notifyLoadStart = false}) {
    if (_isLoading) return;
    _isLoading = true;
    _hasLoadingError = false;
    if (notifyLoadStart) {
      notifyListeners();
    }
    stationBackendService.getAllStations().then((stations) {
      _stations = stations?.list ?? [];
      if (_stations.isNotEmpty) {
        configurationService.getSelectedStationCode().then((code) {
          _setSelectedStation(code);
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
        _setSelectedStation(code);
        notifyListeners();
      });
    }
  }

  void _loadStationMediaLatest() {
    AppStationMediaResponseDto? media = _selectedStation?.latestStationMedia;
    if (_selectedStationMediaFileLatest == null && media != null) {
      AppStationBackendService().getStationMediaFileFromFullUrl(media.url).then((r) {
        if (r != null) {
          _selectedStationMediaFileLatest = r;
          notifyListeners();
        }
      });
    }
  }

  void loadStationMediaReview(String? isoDay) {
    _selectedStationMediaFileReview = null;
    notifyListeners();
    AppStationBackendService().getStationMediaFile(_selectedStation?.code, isoDay).then((r) {
      if (r != null) {
        _selectedStationMediaFileReview = r;
        notifyListeners();
      }
    });
  }

  void _setSelectedStation(String? code) {
    _selectedStation = _stations.firstWhereOrNull((s) => s.code == code);
    _selectedStation ??= _stations.elementAtOrNull(0);
    _selectedStationMediaFileLatest = null;
    _selectedStationMediaFileReview = null;
    _loadStationMediaLatest();
  }

  AppFileModel? get selectedStationMediaFileReview => _selectedStationMediaFileReview;

  AppFileModel? get selectedStationMediaFileLatest => _selectedStationMediaFileLatest;

  List<AppStationResponseDto> get stations => _stations;

  bool get hasLoadingError => _hasLoadingError;

  bool get isLoading => _isLoading;

  AppStationResponseDto? get selectedStation => _selectedStation;
}
