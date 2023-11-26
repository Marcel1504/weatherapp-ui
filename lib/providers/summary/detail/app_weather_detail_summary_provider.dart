import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';
import 'package:weatherapp_ui/providers/summary/detail/app_detail_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/data/detail/app_detail_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/detail/app_weather_detail_data_backend_service.dart';

class AppWeatherDetailSummaryProvider extends AppDetailSummaryProvider<AppWeatherAggregationSummaryListResponseDto,
    AppWeatherAggregationSummaryResponseDto, AppWeatherSortEnum> {
  @override
  AppDetailDataBackendService<AppWeatherAggregationSummaryListResponseDto> getBackendService() {
    return AppWeatherDetailDataBackendService();
  }

  @override
  List<AppWeatherAggregationSummaryResponseDto> getDataFromList(AppWeatherAggregationSummaryListResponseDto? list) {
    return list?.list ?? [];
  }
}
