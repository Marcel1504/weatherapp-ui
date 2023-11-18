import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';
import 'package:weatherapp_ui/services/api/data/detail/app_detail_data_api_service.dart';

class AppSoilDetailDataApiService extends AppDetailDataApiService<AppSoilSummaryDataListResponseDto> {
  @override
  AppSoilSummaryDataListResponseDto convert(String responseBody) {
    return AppSoilSummaryDataListResponseDto.fromJson(jsonDecode(responseBody));
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
