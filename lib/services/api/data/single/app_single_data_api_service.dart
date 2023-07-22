import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weatherapp_ui/services/api/app_api_service.dart';

abstract class AppSingleDataApiService<T> {
  Future<T?> getLatest(String? stationCode) async {
    Response res = await get(
        AppApiService().restUrl("${getBaseEndpoint()}?station=$stationCode"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  @protected
  String getBaseEndpoint();

  @protected
  T convert(String responseBody);
}
