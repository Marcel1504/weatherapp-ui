import 'package:json_annotation/json_annotation.dart';

part 'app_status_response_dto.g.dart';

@JsonSerializable()
class AppStatusResponseDto {
  AppStatusResponseDto({this.message});

  String? message;

  factory AppStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppStatusResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppStatusResponseDtoToJson(this);
}
