import 'package:weatherapp_ui/dto/response/data/single/weather/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/providers/data/single/app_single_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/single/app_single_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/single/app_weather_single_data_api_service.dart';

class AppWeatherSingleDataProvider extends AppSingleDataProvider<AppWeatherSingleDataResponseDto> {
  @override
  AppSingleDataApiService<AppWeatherSingleDataResponseDto> getApiService() {
    return AppWeatherSingleDataApiService();
  }
}
