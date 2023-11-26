import 'package:json_annotation/json_annotation.dart';

enum AppChatWeatherAggregationEnum {
  @JsonValue("day")
  day,
  @JsonValue("month")
  month,
  @JsonValue("year")
  year;
}
