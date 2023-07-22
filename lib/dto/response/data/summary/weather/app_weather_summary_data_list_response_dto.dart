import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/dto/response/data/summary/weather/app_weather_summary_data_response_dto.dart';

part 'app_weather_summary_data_list_response_dto.g.dart';

@JsonSerializable()
class AppWeatherSummaryDataListResponseDto
    extends AppListResponseDto<AppWeatherSummaryDataResponseDto> {
  AppWeatherSummaryDataListResponseDto(
      {super.total, super.hasNext, super.list});

  factory AppWeatherSummaryDataListResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$AppWeatherSummaryDataListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppWeatherSummaryDataListResponseDtoToJson(this);
}
