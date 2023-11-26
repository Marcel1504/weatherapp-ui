import 'package:json_annotation/json_annotation.dart';

part 'app_weather_single_summary_response_dto.g.dart';

@JsonSerializable()
class AppWeatherSingleSummaryResponseDto {
  AppWeatherSingleSummaryResponseDto(this.temperature, this.humidity, this.rainRate, this.wind, this.windDirection,
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

  factory AppWeatherSingleSummaryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppWeatherSingleSummaryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppWeatherSingleSummaryResponseDtoToJson(this);
}
