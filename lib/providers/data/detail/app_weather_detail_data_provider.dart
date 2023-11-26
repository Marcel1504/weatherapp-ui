import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_response_dto.dart';
import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';
import 'package:weatherapp_ui/providers/data/detail/app_detail_data_provider.dart';
import 'package:weatherapp_ui/services/backend/data/detail/app_detail_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/detail/app_weather_detail_data_backend_service.dart';

class AppWeatherDetailDataProvider extends AppDetailDataProvider<AppWeatherSummaryDataListResponseDto,
    AppWeatherSummaryDataResponseDto, AppWeatherSortEnum> {
  @override
  AppDetailDataBackendService<AppWeatherSummaryDataListResponseDto> getBackendService() {
    return AppWeatherDetailDataBackendService();
  }

  @override
  List<AppWeatherSummaryDataResponseDto> getDataFromList(AppWeatherSummaryDataListResponseDto? list) {
    return list?.list ?? [];
  }
}
