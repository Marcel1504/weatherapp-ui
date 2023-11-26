import 'package:weatherapp_ui/dto/response/data/single/weather/app_weather_single_data_response_dto.dart';
import 'package:weatherapp_ui/providers/data/single/app_single_data_provider.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_weather_single_data_backend_service.dart';

class AppWeatherSingleDataProvider extends AppSingleDataProvider<AppWeatherSingleDataResponseDto> {
  @override
  AppSingleDataBackendService<AppWeatherSingleDataResponseDto> getBackendService() {
    return AppWeatherSingleDataBackendService();
  }
}
