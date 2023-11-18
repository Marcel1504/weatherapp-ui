import 'dart:convert';

import 'package:weatherapp_ui/dto/response/data/single/soil/app_soil_single_data_response_dto.dart';
import 'package:weatherapp_ui/services/api/data/single/app_single_data_api_service.dart';

class AppSoilSingleDataApiService extends AppSingleDataApiService<AppSoilSingleDataResponseDto> {
  @override
  AppSoilSingleDataResponseDto convert(String responseBody) {
    return AppSoilSingleDataResponseDto.fromJson(jsonDecode(responseBody));
  }

  @override
  String getBaseEndpoint() {
    return "/soil/latest";
  }
}
