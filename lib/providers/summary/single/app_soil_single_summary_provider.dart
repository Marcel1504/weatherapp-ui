import 'package:weatherapp_ui/dto/response/summary/single/soil/app_soil_single_summary_response_dto.dart';
import 'package:weatherapp_ui/providers/summary/single/app_single_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/summary/single/app_single_summary_backend_service.dart';
import 'package:weatherapp_ui/services/backend/summary/single/app_soil_single_summary_backend_service.dart';

class AppSoilSingleSummaryProvider extends AppSingleSummaryProvider<AppSoilSingleSummaryResponseDto> {
  @override
  AppSingleSummaryBackendService<AppSoilSingleSummaryResponseDto> getBackendService() {
    return AppSoilSingleSummaryBackendService();
  }
}
