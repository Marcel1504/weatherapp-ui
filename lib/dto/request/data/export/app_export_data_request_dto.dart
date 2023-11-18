import 'package:json_annotation/json_annotation.dart';

part 'app_export_data_request_dto.g.dart';

@JsonSerializable()
class AppExportDataRequestDto {
  AppExportDataRequestDto({this.email});

  String? email;

  factory AppExportDataRequestDto.fromJson(Map<String, dynamic> json) => _$AppExportDataRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppExportDataRequestDtoToJson(this);
}
