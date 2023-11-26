import 'package:weatherapp_ui/dto/response/summary/single/soil/app_soil_single_summary_response_dto.dart';
import 'package:weatherapp_ui/providers/summary/single/app_single_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_single_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/single/app_soil_single_data_backend_service.dart';

class AppSoilSingleSummaryProvider extends AppSingleSummaryProvider<AppSoilSingleSummaryResponseDto> {
  @override
  AppSingleDataBackendService<AppSoilSingleSummaryResponseDto> getBackendService() {
    return AppSoilSingleDataBackendService();
  }
}
