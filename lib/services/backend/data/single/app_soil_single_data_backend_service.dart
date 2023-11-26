import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/single/soil/app_soil_single_data_response_dto.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';

class AppSoilSingleDataBackendService extends AppSingleDataBackendService<AppSoilSingleDataResponseDto> {
  @override
  AppSoilSingleDataResponseDto convert(String responseBody) {
    return AppSoilSingleDataResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/soil/latest";
  }
}
