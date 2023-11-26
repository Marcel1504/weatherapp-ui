import 'package:json_annotation/json_annotation.dart';

part 'app_soil_aggregation_summary_response_dto.g.dart';

@JsonSerializable()
class AppSoilAggregationSummaryResponseDto {
  AppSoilAggregationSummaryResponseDto(
      this.amount,
      this.temperature50cmAvg,
      this.temperature50cmMax,
      this.temperature50cmMin,
      this.temperature100cmAvg,
      this.temperature100cmMax,
      this.temperature100cmMin,
      this.temperature200cmAvg,
      this.temperature200cmMax,
      this.temperature200cmMin,
      this.day,
      this.month,
      this.year);

  int? amount;
  double? temperature50cmAvg;
  double? temperature50cmMax;
  double? temperature50cmMin;
  double? temperature100cmAvg;
  double? temperature100cmMax;
  double? temperature100cmMin;
  double? temperature200cmAvg;
  double? temperature200cmMax;
  double? temperature200cmMin;
  String? day;
  String? month;
  String? year;

  factory AppSoilAggregationSummaryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AppSoilAggregationSummaryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppSoilAggregationSummaryResponseDtoToJson(this);
}
