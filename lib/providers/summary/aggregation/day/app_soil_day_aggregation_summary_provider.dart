import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/models/app_soil_filter_model.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/app_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/summary/aggregation/app_aggregation_summary_backend_service.dart';
import 'package:weatherapp_ui/services/backend/summary/aggregation/day/app_soil_day_aggregation_summary_backend_service.dart';

class AppSoilDayAggregationSummaryProvider extends AppAggregationSummaryProvider<
    AppSoilAggregationSummaryListResponseDto, AppSoilAggregationSummaryResponseDto, AppSoilFilterModel> {
  @override
  AppAggregationSummaryBackendService<AppSoilAggregationSummaryListResponseDto, AppSoilFilterModel>
      getBackendService() {
    return AppSoilDayAggregationSummaryBackendService();
  }

  @override
  List<AppSoilAggregationSummaryResponseDto> getDataFromList(AppSoilAggregationSummaryListResponseDto? list) {
    return list != null ? list.list : [];
  }
}
