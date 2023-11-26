import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_response_dto.dart';
import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';
import 'package:weatherapp_ui/providers/data/detail/app_detail_data_provider.dart';
import 'package:weatherapp_ui/services/backend/data/detail/app_detail_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/detail/app_soil_detail_data_backend_service.dart';

class AppSoilDetailDataProvider
    extends AppDetailDataProvider<AppSoilSummaryDataListResponseDto, AppSoilSummaryDataResponseDto, AppSoilSortEnum> {
  @override
  AppDetailDataBackendService<AppSoilSummaryDataListResponseDto> getBackendService() {
    return AppSoilDetailDataBackendService();
  }

  @override
  List<AppSoilSummaryDataResponseDto> getDataFromList(AppSoilSummaryDataListResponseDto? list) {
    return list?.list ?? [];
  }
}
