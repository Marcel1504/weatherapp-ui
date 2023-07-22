import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/single/weather/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/services/api/data/single/app_single_data_api_service.dart';

class AppWeatherSingleDataApiService
    extends AppSingleDataApiService<AppWeatherSingleDataResponseDto> {
  @override
  AppWeatherSingleDataResponseDto convert(String responseBody) {
    return AppWeatherSingleDataResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/latest";
  }
}
