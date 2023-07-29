import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_response_dto.dart';
import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';
import 'package:weatherapp_ui/providers/data/detail/app_detail_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/detail/app_detail_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/detail/app_weather_detail_data_api_service.dart';

class AppWeatherDetailDataProvider extends AppDetailDataProvider<
    AppWeatherSummaryDataListResponseDto,
    AppWeatherSummaryDataResponseDto,
    AppWeatherSortEnum> {
  @override
  AppDetailDataApiService<AppWeatherSummaryDataListResponseDto>
      getApiService() {
    return AppWeatherDetailDataApiService();
  }

  @override
  List<AppWeatherSummaryDataResponseDto> getDataFromList(
      AppWeatherSummaryDataListResponseDto? list) {
    return list?.list ?? [];
  }
}
