import 'dart:convert';

import 'package:weatherapp_ui/dto/response/summary/single/soil/app_soil_single_summary_response_dto.dart';
import 'package:weatherapp_ui/services/backend/summary/single/app_single_summary_backend_service.dart';

class AppSoilSingleSummaryBackendService extends AppSingleSummaryBackendService<AppSoilSingleSummaryResponseDto> {
  @override
  AppSoilSingleSummaryResponseDto convert(String responseBody) {
    return AppSoilSingleSummaryResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/soil/latest";
  }
}
