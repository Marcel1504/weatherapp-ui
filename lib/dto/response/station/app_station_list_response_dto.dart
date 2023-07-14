import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';

import 'app_station_response_dto.dart';

part 'app_station_list_response_dto.g.dart';

@JsonSerializable()
class AppStationListResponseDto {
  AppStationListResponseDto(this.total, this.hasNext, this.list);

  int? total;
  bool? hasNext;
  List<AppStationResponseDto> list = [];

  factory AppStationListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppStationListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppStationListResponseDtoToJson(this);
}
