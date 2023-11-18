import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/models/app_soil_filter_model.dart';
import 'package:weatherapp_ui/services/api/data/summary/app_summary_data_api_service.dart';

class AppSoilMonthApiService extends AppSummaryDataApiService<AppSoilSummaryDataListResponseDto, AppSoilFilterModel> {
  @override
  String buildFilterQuery(AppSoilFilterModel? filter) {
    String filterString = "";
    if (filter?.sort != null) {
      filterString += "&sort=${filter?.sort.name}";
    }
    if (filter?.year != null) {
      filterString += "&year=${filter?.year}";
    }
    return filterString;
  }

  @override
  AppSoilSummaryDataListResponseDto convert(String responseBody) {
    return AppSoilSummaryDataListResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/soil/months/all";
  }
}
