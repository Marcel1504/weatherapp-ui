import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/services/api/app_api_service.dart';

abstract class AppDetailDataApiService<LIST extends AppListResponseDto> {
  Future<LIST?> getDayDetails(String? stationCode, String? day) async {
    Response res =
        await get(AppApiService().restUrl("${getDayDetailsBaseEndpoint()}"
            "?station=$stationCode"
            "&day=$day"
            "&sort=${getDefaultSort()}"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  Future<LIST?> getMonthsDetails(String? stationCode, String? yearMonth) async {
    Response res =
        await get(AppApiService().restUrl("${getMonthDetailsBaseEndpoint()}"
            "?station=$stationCode"
            "&year=${yearMonth?.substring(0, 4)}"
            "&month=${yearMonth?.substring(5, 7)}"
            "&sort=${getDefaultSort()}"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  Future<LIST?> getYearDetails(String? stationCode, String? year) async {
    Response res =
        await get(AppApiService().restUrl("${getYearDetailsBaseEndpoint()}"
            "?station=$stationCode"
            "&year=$year"
            "&size=12"
            "&page=0"
            "&sort=${getDefaultSort()}"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  @protected
  String getDayDetailsBaseEndpoint();

  @protected
  String getMonthDetailsBaseEndpoint();

  @protected
  String getYearDetailsBaseEndpoint();

  @protected
  String getDefaultSort();

  @protected
  LIST convert(String responseBody);
}
