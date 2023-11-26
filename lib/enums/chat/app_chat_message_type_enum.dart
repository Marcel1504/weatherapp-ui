import 'package:json_annotation/json_annotation.dart';

enum AppChatMessageTypeEnum {
  @JsonValue("TEXT")
  text,
  @JsonValue("LOADING")
  loading,
  @JsonValue("WEATHER_DATA")
  weatherData,
  @JsonValue("ERROR")
  error
}
