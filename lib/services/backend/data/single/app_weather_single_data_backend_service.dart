import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/single/weather/app_weather_single_summary_response_dto.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';

class AppWeatherSingleDataBackendService extends AppSingleDataBackendService<AppWeatherSingleSummaryResponseDto> {
  @override
  AppWeatherSingleSummaryResponseDto convert(String responseBody) {
    return AppWeatherSingleSummaryResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/latest";
  }
}
