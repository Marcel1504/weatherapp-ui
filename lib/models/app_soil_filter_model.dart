import 'package:weatherapp_ui/enums/app_soil_sort_enum.dart';

class AppSoilFilterModel {
  AppSoilSortEnum sort;
  String? startDay;
  String? endDay;
  String? year;

  AppSoilFilterModel(
      {this.startDay,
      this.endDay,
      this.year,
      this.sort = AppSoilSortEnum.LATEST});
}
