import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/single/weather/app_weather_single_summary_response_dto.dart';
import 'package:weatherapp_ui/services/backend/summary/single/app_single_summary_backend_service.dart';

class AppWeatherSingleSummaryBackendService extends AppSingleSummaryBackendService<AppWeatherSingleSummaryResponseDto> {
  @override
  AppWeatherSingleSummaryResponseDto convert(String responseBody) {
    return AppWeatherSingleSummaryResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/latest";
  }
}
