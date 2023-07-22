import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';

import 'app_station_response_dto.dart';

part 'app_station_list_response_dto.g.dart';

@JsonSerializable()
class AppStationListResponseDto
    extends AppListResponseDto<AppStationResponseDto> {
  AppStationListResponseDto({super.total, super.hasNext, super.list});

  factory AppStationListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppStationListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppStationListResponseDtoToJson(this);
}
