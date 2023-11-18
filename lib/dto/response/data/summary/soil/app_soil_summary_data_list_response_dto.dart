import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/soil/app_soil_summary_data_response_dto.dart';

part 'app_soil_summary_data_list_response_dto.g.dart';

@JsonSerializable()
class AppSoilSummaryDataListResponseDto extends AppListResponseDto<AppSoilSummaryDataResponseDto> {
  AppSoilSummaryDataListResponseDto({super.total, super.hasNext, super.list});

  factory AppSoilSummaryDataListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppSoilSummaryDataListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppSoilSummaryDataListResponseDtoToJson(this);
}
