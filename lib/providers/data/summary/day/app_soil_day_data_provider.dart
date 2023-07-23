import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_response_dto.dart';
import 'package:weatherapp_ui/models/app_soil_filter_model.dart';
import 'package:weatherapp_ui/providers/data/summary/app_summary_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/summary/app_summary_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/summary/day/app_soil_day_data_api_service.dart';

class AppSoilDayDataProvider extends AppSummaryDataProvider<
    AppSoilSummaryDataListResponseDto,
    AppSoilSummaryDataResponseDto,
    AppSoilFilterModel> {
  @override
  AppSummaryDataApiService<AppSoilSummaryDataListResponseDto,
      AppSoilFilterModel> getApiService() {
    return AppSoilDayApiService();
  }

  @override
  List<AppSoilSummaryDataResponseDto> getDataFromList(
      AppSoilSummaryDataListResponseDto? list) {
    return list != null ? list.list : [];
  }
}