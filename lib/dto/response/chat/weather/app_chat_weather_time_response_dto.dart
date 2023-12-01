import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_weather_aggregation_enum.dart';

part 'app_chat_weather_time_response_dto.g.dart';

@JsonSerializable()
class AppChatWeatherTimeResponseDto {
  AppChatWeatherTimeResponseDto(
      {this.temperature, this.windMax, this.humidity, this.rainTotal, this.date, this.station, this.aggregation});

  double? temperature;
  double? windMax;
  double? humidity;
  double? rainTotal;
  String? date;
  String? station;
  AppChatWeatherAggregationEnum? aggregation;

  factory AppChatWeatherTimeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppChatWeatherTimeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppChatWeatherTimeResponseDtoToJson(this);
}
