import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/services/api/app_api_service.dart';

class AppStationApiService {
  Future<AppStationResponseDto?> getStation(String code) async {
    Response res = await get(
        AppApiService().restUrl("/station?code=$code"));
    return res.statusCode == 200
        ? AppStationResponseDto.fromJson(jsonDecode(res.body))
        : null;
  }

  Future<AppStationListResponseDto?> getAllStations() async {
    Response res = await get(
        AppApiService().restUrl("/station/all"));
    return res.statusCode == 200
        ? AppStationListResponseDto.fromJson(jsonDecode(res.body))
        : null;
  }
}
