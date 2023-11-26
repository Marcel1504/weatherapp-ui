import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weatherapp_ui/services/backend/app_backend_service.dart';

abstract class AppSingleDataBackendService<T> extends AppBackendService {
  Future<T?> getLatest(String? stationCode) async {
    Response res = await get(apiUrl("${getBaseEndpoint()}?station=$stationCode"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  @protected
  String getBaseEndpoint();

  @protected
  T convert(String responseBody);
}
