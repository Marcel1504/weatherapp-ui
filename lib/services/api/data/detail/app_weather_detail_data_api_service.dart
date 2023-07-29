import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';
import 'package:weatherapp_ui/services/api/data/detail/app_detail_data_api_service.dart';

class AppWeatherDetailDataApiService
    extends AppDetailDataApiService<AppWeatherSummaryDataListResponseDto> {
  @override
  AppWeatherSummaryDataListResponseDto convert(String responseBody) {
    return AppWeatherSummaryDataListResponseDto.fromJson(
        jsonDecode(responseBody));
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
