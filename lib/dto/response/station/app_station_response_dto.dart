import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_media_response_dto.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';

part 'app_station_response_dto.g.dart';

@JsonSerializable()
class AppStationResponseDto {
  AppStationResponseDto(this.code, this.name, this.type, this.latitude,
      this.longitude, this.altitude);

  String? code;
  String? name;
  AppStationTypeEnum? type;
  double? latitude;
  double? longitude;
  int? altitude;
  String? lastActivity;
  List<AppStationMediaResponseDto>? stationImageUrls;

  factory AppStationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppStationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppStationResponseDtoToJson(this);
}
