import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/request/ventilation/app_ventilation_request_dto.dart';
import 'package:weatherapp_ui/dto/response/ventilation/app_ventilation_response_dto.dart';
import 'package:weatherapp_ui/services/backend/ventilation/app_ventilation_backend_service.dart';

class AppVentilationProvider extends ChangeNotifier {
  double? _temperatureOutside;
  double? _temperatureInside;
  int? _humidityOutside;
  int? _humidityInside;
  AppVentilationResponseDto? _result;
  bool _loading = false;

  void determineNeedForVentilation(
      {double? temperatureOutside, double? temperatureInside, int? humidityInside, int? humidityOutside}) async {
    if (!_loading) {
      _loading = true;
      AppVentilationBackendService()
          .determineVentilationDemand(AppVentilationRequestDto(
              temperatureIn: temperatureInside,
              temperatureOut: temperatureOutside,
              humidityIn: humidityInside,
              humidityOut: humidityOutside))
          .then((r) {
        _result = r;
        _temperatureOutside = temperatureOutside;
        _temperatureInside = temperatureInside;
        _humidityOutside = humidityOutside;
        _humidityInside = humidityInside;
        _loading = false;
        notifyListeners();
      }).catchError((e) {
        _loading = false;
        notifyListeners();
      });
    }
  }

  bool get loading => _loading;

  AppVentilationResponseDto? get result => _result;

  int? get humidityInside => _humidityInside;

  int? get humidityOutside => _humidityOutside;

  double? get temperatureInside => _temperatureInside;

  double? get temperatureOutside => _temperatureOutside;
}
