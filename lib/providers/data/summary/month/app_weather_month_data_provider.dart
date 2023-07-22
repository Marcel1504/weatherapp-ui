import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/providers/data/summary/app_summary_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/summary/app_summary_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/summary/month/app_weather_month_data_api_service.dart';

class AppWeatherMonthDataProvider extends AppSummaryDataProvider<
    AppWeatherSummaryDataListResponseDto,
    AppWeatherSummaryDataResponseDto,
    AppWeatherFilterModel> {
  @override
  AppSummaryDataApiService<AppWeatherSummaryDataListResponseDto,
      AppWeatherFilterModel> getApiService() {
    return AppWeatherMonthApiService();
  }

  @override
  List<AppWeatherSummaryDataResponseDto> getDataFromList(
      AppWeatherSummaryDataListResponseDto? list) {
    return list != null ? list.list : [];
  }
}
