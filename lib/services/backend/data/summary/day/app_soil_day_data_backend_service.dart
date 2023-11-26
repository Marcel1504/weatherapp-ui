import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/models/app_soil_filter_model.dart';
import 'package:weatherapp_ui/services/backend/data/summary/app_summary_data_backend_service.dart';

class AppSoilDayBackendService
    extends AppSummaryDataBackendService<AppSoilAggregationSummaryListResponseDto, AppSoilFilterModel> {
  @override
  String buildFilterQuery(AppSoilFilterModel? filter) {
    String filterString = "";
    if (filter?.sort != null) {
      filterString += "&sort=${filter?.sort.name}";
    }
    if (filter?.startDay != null) {
      filterString += "&startDay=${filter?.startDay}";
    }
    if (filter?.endDay != null) {
      filterString += "&endDay=${filter?.endDay}";
    }
    return filterString;
  }

  @override
  AppSoilAggregationSummaryListResponseDto convert(String responseBody) {
    return AppSoilAggregationSummaryListResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/soil/days/all";
  }
}
