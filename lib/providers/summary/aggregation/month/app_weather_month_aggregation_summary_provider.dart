import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/app_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/summary/aggregation/app_aggregation_summary_backend_service.dart';
import 'package:weatherapp_ui/services/backend/summary/aggregation/month/app_weather_month_aggregation_summary_backend_service.dart';

class AppWeatherMonthAggregationSummaryProvider extends AppAggregationSummaryProvider<
    AppWeatherAggregationSummaryListResponseDto, AppWeatherAggregationSummaryResponseDto, AppWeatherFilterModel> {
  @override
  AppAggregationSummaryBackendService<AppWeatherAggregationSummaryListResponseDto, AppWeatherFilterModel>
      getBackendService() {
    return AppWeatherMonthAggregationSummaryBackendService();
  }

  @override
  List<AppWeatherAggregationSummaryResponseDto> getDataFromList(AppWeatherAggregationSummaryListResponseDto? list) {
    return list != null ? list.list : [];
  }
}
