import 'package:json_annotation/json_annotation.dart';

enum AppChatWeatherRecordEnum {
  @JsonValue("hottest")
  hottest,
  @JsonValue("coldest")
  coldest,
  @JsonValue("mostRain")
  mostRain,
  @JsonValue("strongestWind")
  strongestWind;
}
