import 'package:json_annotation/json_annotation.dart';

part 'app_ventilation_request_dto.g.dart';

@JsonSerializable()
class AppVentilationRequestDto {
  AppVentilationRequestDto({this.temperatureIn, this.temperatureOut, this.humidityIn, this.humidityOut});

  double? temperatureIn;
  double? temperatureOut;
  int? humidityIn;
  int? humidityOut;

  factory AppVentilationRequestDto.fromJson(Map<String, dynamic> json) => _$AppVentilationRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppVentilationRequestDtoToJson(this);
}
