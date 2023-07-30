import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_response_dto.dart';
import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';
import 'package:weatherapp_ui/providers/data/detail/app_detail_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/detail/app_detail_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/detail/app_soil_detail_data_api_service.dart';

class AppSoilDetailDataProvider extends AppDetailDataProvider<
    AppSoilSummaryDataListResponseDto,
    AppSoilSummaryDataResponseDto,
    AppSoilSortEnum> {
  @override
  AppDetailDataApiService<AppSoilSummaryDataListResponseDto> getApiService() {
    return AppSoilDetailDataApiService();
  }

  @override
  List<AppSoilSummaryDataResponseDto> getDataFromList(
      AppSoilSummaryDataListResponseDto? list) {
    return list?.list ?? [];
  }
}
