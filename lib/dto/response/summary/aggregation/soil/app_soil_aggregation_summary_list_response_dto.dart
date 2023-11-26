import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/summary/aggregation/soil/app_soil_aggregation_summary_response_dto.dart';

part 'app_soil_aggregation_summary_list_response_dto.g.dart';

@JsonSerializable()
class AppSoilAggregationSummaryListResponseDto extends AppListResponseDto<AppSoilAggregationSummaryResponseDto> {
  AppSoilAggregationSummaryListResponseDto({super.total, super.hasNext, super.list});

  factory AppSoilAggregationSummaryListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppSoilAggregationSummaryListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppSoilAggregationSummaryListResponseDtoToJson(this);
}
