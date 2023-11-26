import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/weather/app_weather_aggregation_summary_response_dto.dart';

part 'app_weather_aggregation_summary_list_response_dto.g.dart';

@JsonSerializable()
class AppWeatherAggregationSummaryListResponseDto extends AppListResponseDto<AppWeatherAggregationSummaryResponseDto> {
  AppWeatherAggregationSummaryListResponseDto({super.total, super.hasNext, super.list});

  factory AppWeatherAggregationSummaryListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppWeatherAggregationSummaryListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppWeatherAggregationSummaryListResponseDtoToJson(this);
}
