import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/enums/app_weather_wind_direction_enum.dart';

part 'app_weather_summary_data_response_dto.g.dart';

@JsonSerializable()
class AppWeatherSummaryDataResponseDto {
  AppWeatherSummaryDataResponseDto(
      this.amount,
      this.temperatureAvg,
      this.temperatureMax,
      this.temperatureMin,
      this.humidityAvg,
      this.humidityMax,
      this.humidityMin,
      this.rainTotal,
      this.rainRateMax,
      this.windMax,
      this.windDirectionCluster,
      this.pressureAvg,
      this.pressureMax,
      this.pressureMin,
      this.solarRadiationAvg,
      this.solarRadiationMax,
      this.solarRadiationMin,
      this.hour,
      this.day,
      this.month,
      this.year);

  int? amount;
  double? temperatureAvg;
  double? temperatureMax;
  double? temperatureMin;
  double? humidityAvg;
  int? humidityMax;
  int? humidityMin;
  double? rainTotal;
  double? rainRateMax;
  double? windMax;
  AppWeatherWindDirectionEnum? windDirectionCluster;
  double? pressureAvg;
  double? pressureMax;
  double? pressureMin;
  double? solarRadiationAvg;
  double? solarRadiationMax;
  double? solarRadiationMin;
  String? hour;
  String? day;
  String? month;
  String? year;

  factory AppWeatherSummaryDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppWeatherSummaryDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppWeatherSummaryDataResponseDtoToJson(this);
}
