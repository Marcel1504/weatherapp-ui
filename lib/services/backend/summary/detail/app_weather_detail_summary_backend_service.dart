import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';
import 'package:weatherapp_ui/services/backend/summary/detail/app_detail_summary_backend_service.dart';

class AppWeatherDetailDataBackendService
    extends AppDetailDataBackendService<AppWeatherAggregationSummaryListResponseDto> {
  @override
  AppWeatherAggregationSummaryListResponseDto convert(String responseBody) {
    return AppWeatherAggregationSummaryListResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getDayDetailsBaseEndpoint() {
    return "/weather/hours";
  }

  @override
  String getDefaultSort() {
    return AppWeatherSortEnum.OLDEST.name;
  }

  @override
  String getMonthDetailsBaseEndpoint() {
    return "/weather/days";
  }

  @override
  String getYearDetailsBaseEndpoint() {
    return "/weather/months/all";
  }
}
