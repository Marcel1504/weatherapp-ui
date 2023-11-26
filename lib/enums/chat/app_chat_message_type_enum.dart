import 'package:json_annotation/json_annotation.dart';

enum AppChatMessageTypeEnum {
  @JsonValue("TEXT")
  text,
  @JsonValue("ERROR")
  error,
  @JsonValue("LOADING")
  loading,
  @JsonValue("WEATHER_TIME")
  weatherTime,
  @JsonValue("WEATHER_RECORD")
  weatherRecord,
  @JsonValue("WEATHER_MEDIA")
  weatherMedia
}
