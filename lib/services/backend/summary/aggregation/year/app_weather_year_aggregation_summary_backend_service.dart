import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/services/backend/summary/aggregation/app_aggregation_summary_backend_service.dart';

class AppWeatherYearAggregationSummaryBackendService
    extends AppAggregationSummaryBackendService<AppWeatherAggregationSummaryListResponseDto, AppWeatherFilterModel> {
  @override
  String buildFilterQuery(AppWeatherFilterModel? filter) {
    String filterString = "";
    if (filter?.sort != null) {
      filterString += "&sort=${filter?.sort.name}";
    }
    return filterString;
  }

  @override
  AppWeatherAggregationSummaryListResponseDto convert(String responseBody) {
    return AppWeatherAggregationSummaryListResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/weather/years/all";
  }
}
