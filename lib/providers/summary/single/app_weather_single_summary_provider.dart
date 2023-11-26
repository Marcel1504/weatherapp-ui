import 'package:weatherapp_ui/dto/response/summary/single/weather/app_weather_single_summary_response_dto.dart';
import 'package:weatherapp_ui/providers/summary/single/app_single_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_weather_single_data_backend_service.dart';

class AppWeatherSingleSummaryProvider extends AppSingleSummaryProvider<AppWeatherSingleSummaryResponseDto> {
  @override
  AppSingleDataBackendService<AppWeatherSingleSummaryResponseDto> getBackendService() {
    return AppWeatherSingleDataBackendService();
  }
}
