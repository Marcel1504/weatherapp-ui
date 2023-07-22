import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';

class AppSoilFilterModel {
  AppSoilSortEnum sort;
  String? startDate;
  String? endDate;
  String? year;

  AppSoilFilterModel(
      {this.startDate,
      this.endDate,
      this.year,
      this.sort = AppSoilSortEnum.LATEST});
}
