import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/models/app_soil_filter_model.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/app_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/data/summary/app_summary_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/summary/year/app_soil_year_data_backend_service.dart';

class AppSoilYearAggregationSummaryProvider extends AppAggregationSummaryProvider<
    AppSoilAggregationSummaryListResponseDto, AppSoilAggregationSummaryResponseDto, AppSoilFilterModel> {
  @override
  AppSummaryDataBackendService<AppSoilAggregationSummaryListResponseDto, AppSoilFilterModel> getBackendService() {
    return AppSoilYearBackendService();
  }

  @override
  List<AppSoilAggregationSummaryResponseDto> getDataFromList(AppSoilAggregationSummaryListResponseDto? list) {
    return list != null ? list.list : [];
  }
}
