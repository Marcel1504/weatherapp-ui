import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/models/app_file_model.dart';
import 'package:weatherapp_ui/services/backend/app_backend_service.dart';

class AppStationBackendService extends AppBackendService {
  Future<AppStationResponseDto?> getStation(String code) async {
    Response res = await get(apiUrl("/station?code=$code"));
    return res.statusCode == 200 ? AppStationResponseDto.fromJson(jsonDecode(res.body)) : null;
  }

  Future<AppStationListResponseDto?> getAllStations() async {
    Response res = await get(apiUrl("/station/all"));
    return res.statusCode == 200 ? AppStationListResponseDto.fromJson(jsonDecode(res.body)) : null;
  }

  Future<AppFileModel?> getStationMediaFile(String? stationCode, String? name) async {
    if (stationCode == null || name == null) {
      return null;
    }
    Uri uri = apiUrl("/station/media?station=$stationCode&name=$name");
    Response response = await get(uri);
    return response.statusCode == 200 ? AppFileModel(data: response.bodyBytes, url: uri.toString()) : null;
  }

  Future<AppFileModel?> getStationMediaFileFromFullUrl(String? url) async {
    if (url == null) {
      return null;
    }
    Response response = await get(Uri.parse(url));
    return response.statusCode == 200 ? AppFileModel(data: response.bodyBytes, url: url) : null;
  }
}
