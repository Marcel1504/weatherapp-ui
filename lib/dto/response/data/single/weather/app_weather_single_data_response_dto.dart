import 'package:json_annotation/json_annotation.dart';

part 'app_weather_single_data_response_dto.g.dart';

@JsonSerializable()
class AppWeatherSingleDataResponseDto {
  AppWeatherSingleDataResponseDto(this.temperature, this.humidity, this.rainRate, this.wind, this.windDirection,
      this.pressure, this.solarRadiation, this.lastRain, this.timestamp);

  double? temperature;
  int? humidity;
  double? rainRate;
  double? wind;
  int? windDirection;
  double? pressure;
  double? solarRadiation;
  String? lastRain;
  String? timestamp;

  factory AppWeatherSingleDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppWeatherSingleDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppWeatherSingleDataResponseDtoToJson(this);
}
