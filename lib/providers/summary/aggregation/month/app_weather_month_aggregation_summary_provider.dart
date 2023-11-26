import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_response_dto.dart';
import 'package:weatherapp_ui/models/app_weather_filter_model.dart';
import 'package:weatherapp_ui/providers/summary/aggregation/app_aggregation_summary_provider.dart';
import 'package:weatherapp_ui/services/backend/data/summary/app_summary_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/summary/month/app_weather_month_data_backend_service.dart';

class AppWeatherMonthAggregationSummaryProvider extends AppAggregationSummaryProvider<
    AppWeatherAggregationSummaryListResponseDto, AppWeatherAggregationSummaryResponseDto, AppWeatherFilterModel> {
  @override
  AppSummaryDataBackendService<AppWeatherAggregationSummaryListResponseDto, AppWeatherFilterModel> getBackendService() {
    return AppWeatherMonthBackendService();
  }

  @override
  List<AppWeatherAggregationSummaryResponseDto> getDataFromList(AppWeatherAggregationSummaryListResponseDto? list) {
    return list != null ? list.list : [];
  }
}
