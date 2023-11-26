import 'package:json_annotation/json_annotation.dart';

part 'app_soil_single_summary_response_dto.g.dart';

@JsonSerializable()
class AppSoilSingleSummaryResponseDto {
  AppSoilSingleSummaryResponseDto(this.temperature50cm, this.temperature100cm, this.temperature200cm, this.timestamp);

  double? temperature50cm;
  double? temperature100cm;
  double? temperature200cm;
  String? timestamp;

  factory AppSoilSingleSummaryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppSoilSingleSummaryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppSoilSingleSummaryResponseDtoToJson(this);
}
