import 'package:weatherapp_ui/dto/response/data/single/app_soil_single_data_response_dto.dart';
import 'package:weatherapp_ui/providers/data/single/app_single_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/single/app_single_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/single/impl/app_soil_single_data_api_service.dart';

class AppSoilSingleDataProvider
    extends AppSingleDataProvider<AppSoilSingleDataResponseDto> {
  @override
  AppSingleDataApiService<AppSoilSingleDataResponseDto> getApiService() {
    return AppSoilSingleDataApiService();
  }
}
