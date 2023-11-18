import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/enums/app_ventilation_indicator_enum.dart';

part 'app_ventilation_response_dto.g.dart';

@JsonSerializable()
class AppVentilationResponseDto {
  AppVentilationResponseDto(this.absoluteHumidityOut, this.absoluteHumidityIn, this.indicator);

  double? absoluteHumidityOut;
  double? absoluteHumidityIn;
  AppVentilationIndicatorEnum? indicator;

  factory AppVentilationResponseDto.fromJson(Map<String, dynamic> json) => _$AppVentilationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppVentilationResponseDtoToJson(this);
}
