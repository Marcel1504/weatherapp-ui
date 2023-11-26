import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/request/data/export/app_export_data_request_dto.dart';
import 'package:weatherapp_ui/dto/response/status/app_status_response_dto.dart';
import 'package:weatherapp_ui/services/backend/app_backend_service.dart';

abstract class AppExportDataBackendService extends AppBackendService {
  Future<AppStatusResponseDto?> export(
      String? stationCode, String? startDay, String? endDay, AppExportDataRequestDto? request) async {
    Response res = await post(
        apiUrl("${getExportEndpoint()}"
            "?station=$stationCode"
            "&startDay=$startDay"
            "&endDay=$endDay"),
        body: jsonEncode(request?.toJson()),
        headers: {"Content-Type": "application/json"});
    return res.statusCode == 200 ? AppStatusResponseDto.fromJson(jsonDecode(res.body)) : null;
  }

  @protected
  String getExportEndpoint();
}
