import 'package:weatherapp_ui/dto/response/data/single/soil/app_soil_single_data_response_dto.dart';
import 'package:weatherapp_ui/providers/data/single/app_single_data_provider.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_soil_single_data_backend_service.dart';

class AppSoilSingleDataProvider extends AppSingleDataProvider<AppSoilSingleDataResponseDto> {
  @override
  AppSingleDataBackendService<AppSoilSingleDataResponseDto> getBackendService() {
    return AppSoilSingleDataBackendService();
  }
}
