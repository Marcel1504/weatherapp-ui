import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/services/api/data/summary/app_summary_data_api_service.dart';

class AppWeatherDayApiService extends AppSummaryDataApiService<
    AppWeatherSummaryDataListResponseDto, AppWeatherFilterModel> {
  @override
  String buildFilterQuery(AppWeatherFilterModel? filter) {
    return "";
  }

  @override
  AppWeatherSummaryDataListResponseDto convert(String responseBody) {
    return AppWeatherSummaryDataListResponseDto.fromJson(
        jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/days/all";
  }
}
