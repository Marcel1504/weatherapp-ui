import 'package:json_annotation/json_annotation.dart';

part 'app_weather_single_data_response_dto.g.dart';

@JsonSerializable()
class AppWeatherSingleDataResponseDto {
  AppWeatherSingleDataResponseDto(
      this.temperature,
      this.humidity,
      this.rainSinceLast,
      this.rainRate,
      this.wind,
      this.windDirection,
      this.pressure,
      this.solarRadiation,
      this.secondsSinceLast,
      this.timestamp);

  double? temperature;
  int? humidity;
  double? rainSinceLast;
  double? rainRate;
  double? wind;
  int? windDirection;
  double? pressure;
  double? solarRadiation;
  int? secondsSinceLast;
  String? timestamp;

  factory AppWeatherSingleDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppWeatherSingleDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AppWeatherSingleDataResponseDtoToJson(this);
}
