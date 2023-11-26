import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/providers/data/summary/app_summary_data_provider.dart';
import 'package:weatherapp_ui/services/backend/data/summary/app_summary_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/summary/day/app_weather_day_data_backend_service.dart';

class AppWeatherDayDataProvider extends AppSummaryDataProvider<AppWeatherSummaryDataListResponseDto,
    AppWeatherSummaryDataResponseDto, AppWeatherFilterModel> {
  @override
  AppSummaryDataBackendService<AppWeatherSummaryDataListResponseDto, AppWeatherFilterModel> getBackendService() {
    return AppWeatherDayBackendService();
  }

  @override
  List<AppWeatherSummaryDataResponseDto> getDataFromList(AppWeatherSummaryDataListResponseDto? list) {
    return list != null ? list.list : [];
  }
}
