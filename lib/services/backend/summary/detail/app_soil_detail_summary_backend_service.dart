import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';
import 'package:weatherapp_ui/services/backend/summary/detail/app_detail_summary_backend_service.dart';

class AppSoilDetailDataBackendService extends AppDetailDataBackendService<AppSoilAggregationSummaryListResponseDto> {
  @override
  AppSoilAggregationSummaryListResponseDto convert(String responseBody) {
    return AppSoilAggregationSummaryListResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getDayDetailsBaseEndpoint() {
    throw UnimplementedError();
  }

  @override
  String getDefaultSort() {
    return AppSoilSortEnum.OLDEST.name;
  }

  @override
  String getMonthDetailsBaseEndpoint() {
    return "/soil/days";
  }

  @override
  String getYearDetailsBaseEndpoint() {
    return "/soil/months/all";
  }
}
