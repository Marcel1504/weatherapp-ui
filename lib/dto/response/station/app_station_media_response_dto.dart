import 'package:json_annotation/json_annotation.dart';

part 'app_station_media_response_dto.g.dart';

@JsonSerializable()
class AppStationMediaResponseDto {
  AppStationMediaResponseDto(this.created, this.url);

  String? created;
  String? url;

  factory AppStationMediaResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppStationMediaResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppStationMediaResponseDtoToJson(this);
}