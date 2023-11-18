import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/request/ventilation/app_ventilation_request_dto.dart';
import 'package:weatherapp_ui/dto/response/ventilation/app_ventilation_response_dto.dart';
import 'package:weatherapp_ui/services/api/app_api_service.dart';

class AppVentilationApiService extends AppApiService {
  Future<AppVentilationResponseDto?> determineVentilationDemand(AppVentilationRequestDto input) async {
    Response res = await put(AppApiService().restUrl("/ventilation"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(input.toJson()));
    return res.statusCode == 200 ? AppVentilationResponseDto.fromJson(jsonDecode(res.body)) : null;
  }
}
