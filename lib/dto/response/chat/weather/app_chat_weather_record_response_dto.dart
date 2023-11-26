import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_weather_aggregation_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_weather_record_enum.dart';

part 'app_chat_weather_record_response_dto.g.dart';

@JsonSerializable()
class AppChatWeatherRecordResponseDto {
  AppChatWeatherRecordResponseDto({
    this.temperatureMax,
    this.temperatureMin,
    this.windMax,
    this.rainTotal,
    this.date,
    this.station,
    this.aggregation,
  });

  double? temperatureMax;
  double? temperatureMin;
  double? windMax;
  double? humidity;
  double? rainTotal;
  String? date;
  String? station;
  AppChatWeatherRecordEnum? type;
  AppChatWeatherAggregationEnum? aggregation;

  factory AppChatWeatherRecordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppChatWeatherRecordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppChatWeatherRecordResponseDtoToJson(this);
}
