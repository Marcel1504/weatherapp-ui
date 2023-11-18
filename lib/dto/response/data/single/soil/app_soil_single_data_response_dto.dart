import 'package:json_annotation/json_annotation.dart';

part 'app_soil_single_data_response_dto.g.dart';

@JsonSerializable()
class AppSoilSingleDataResponseDto {
  AppSoilSingleDataResponseDto(this.temperature50cm, this.temperature100cm, this.temperature200cm, this.timestamp);

  double? temperature50cm;
  double? temperature100cm;
  double? temperature200cm;
  String? timestamp;

  factory AppSoilSingleDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppSoilSingleDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppSoilSingleDataResponseDtoToJson(this);
}
