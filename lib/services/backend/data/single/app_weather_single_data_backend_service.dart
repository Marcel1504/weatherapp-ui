import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/single/weather/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';

class AppWeatherSingleDataBackendService extends AppSingleDataBackendService<AppWeatherSingleDataResponseDto> {
  @override
  AppWeatherSingleDataResponseDto convert(String responseBody) {
    return AppWeatherSingleDataResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/latest";
  }
}
