import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/single/soil/app_soil_single_summary_response_dto.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';

class AppSoilSingleDataBackendService extends AppSingleDataBackendService<AppSoilSingleSummaryResponseDto> {
  @override
  AppSoilSingleSummaryResponseDto convert(String responseBody) {
    return AppSoilSingleSummaryResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/soil/latest";
  }
}
