import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/services/api/app_api_service.dart';

abstract class AppSummaryDataApiService<LIST extends AppListResponseDto, FILTER> {
  Future<LIST?> getNext(String? stationCode, int page, FILTER? filter) async {
    Response res = await get(AppApiService()
        .restUrl("${getBaseEndpoint()}?station=$stationCode&page=$page&size=25${buildFilterQuery(filter)}"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  @protected
  String getBaseEndpoint();

  @protected
  String buildFilterQuery(FILTER? filter);

  @protected
  LIST convert(String responseBody);
}
