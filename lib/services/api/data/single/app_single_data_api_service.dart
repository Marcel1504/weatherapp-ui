import 'package:http/http.dart';
import 'package:weatherapp_ui/services/api/app_api_service.dart';

abstract class AppSingleDataApiService<T> {
  Future<T?> getLatest(String? stationCode) async {
    Response res = await get(
        AppApiService().restUrl("${getBaseEndpoint()}?station=$stationCode"));
    return res.statusCode == 200 ? convert(res.body) : null;
  }

  String getBaseEndpoint();

  T convert(String responseBody);
}
