import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/services/backend/data/summary/app_summary_data_backend_service.dart';

class AppWeatherYearBackendService
    extends AppSummaryDataBackendService<AppWeatherSummaryDataListResponseDto, AppWeatherFilterModel> {
  @override
  String buildFilterQuery(AppWeatherFilterModel? filter) {
    String filterString = "";
    if (filter?.sort != null) {
      filterString += "&sort=${filter?.sort.name}";
    }
    return filterString;
  }

  @override
  AppWeatherSummaryDataListResponseDto convert(String responseBody) {
    return AppWeatherSummaryDataListResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/years/all";
  }
}
