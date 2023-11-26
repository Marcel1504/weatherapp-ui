import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';
import 'package:weatherapp_ui/providers/summary/detail/app_detail_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/summary/detail/app_detail_summary_backend_service.dart';
import 'package:weatherapp_ui/services/backend/summary/detail/app_soil_detail_summary_backend_service.dart';

class AppSoilDetailSummaryProvider extends AppDetailSummaryProvider<AppSoilAggregationSummaryListResponseDto,
    AppSoilAggregationSummaryResponseDto, AppSoilSortEnum> {
  @override
  AppDetailDataBackendService<AppSoilAggregationSummaryListResponseDto> getBackendService() {
    return AppSoilDetailDataBackendService();
  }

  @override
  List<AppSoilAggregationSummaryResponseDto> getDataFromList(AppSoilAggregationSummaryListResponseDto? list) {
    return list?.list ?? [];
  }
}
